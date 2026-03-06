import 'package:cloud_firestore/cloud_firestore.dart';

import 'group_info.dart';
import 'participant.dart';
import '../messages/message.dart';

enum ConversationsType { group, solo }

class _Field {
  static const String conversationId = 'conversationId';
  static const String conversationsType = 'conversationsType';
  static const String hostId = 'hostId';
  static const String createdAt = 'createdAt';
  static const String lastUpdate = 'lastUpdate';
  static const String lastMessage = 'lastMessage';
  static const String memberIds = 'memberIds';
  static const String participants = 'participants';
  static const String messageCount = 'messageCount';
  static const String groupInfo = 'groupInfo';
}

class Conversations {
  final String conversationId;
  final ConversationsType conversationsType;
  final String hostId;
  final Timestamp createdAt;
  final Timestamp lastUpdate;
  final Message lastMessage;
  final Map<String, String> memberIds;
  final Map<String, Participant> participants;
  final int messageCount;
  final GroupInfo? groupInfo;

  Conversations({
    required this.conversationId,
    required this.conversationsType,
    required this.hostId,
    required this.createdAt,
    required this.lastUpdate,
    required this.lastMessage,
    required this.memberIds,
    required this.participants,
    required this.messageCount,
    this.groupInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      _Field.conversationId: conversationId,
      _Field.conversationsType: conversationsType.name,
      _Field.hostId: hostId,
      _Field.createdAt: createdAt,
      _Field.lastUpdate: lastUpdate,
      _Field.lastMessage: lastMessage.toMap(),
      _Field.memberIds: memberIds,
      _Field.participants: participants.map((key, value) => MapEntry(key, value.toMap())),
      _Field.messageCount: messageCount,
      _Field.groupInfo: groupInfo?.toMap(),
    };
  }

  factory Conversations.fromMap(Map<String, dynamic> map) {
    return Conversations(
      conversationId: map[_Field.conversationId] ?? '',
      conversationsType: ConversationsType.values.asNameMap()[map[_Field.conversationsType]] ?? ConversationsType.solo,
      hostId: map[_Field.hostId] ?? '',
      createdAt: map[_Field.createdAt] ?? Timestamp.now(),
      lastUpdate: map[_Field.lastUpdate] ?? Timestamp.now(),
      lastMessage: Message.fromMap(map[_Field.lastMessage] ?? {}),
      memberIds: Map<String, String>.from(map[_Field.memberIds] ?? {}),
      participants: (map[_Field.participants] as Map<String, dynamic>? ?? {}).map(
        (key, value) => MapEntry(key, Participant.fromMap(value as Map<String, dynamic>)),
      ),
      messageCount: (map[_Field.messageCount] ?? 0).toInt(),
      groupInfo: map[_Field.groupInfo] != null
          ? GroupInfo.fromMap(map[_Field.groupInfo] as Map<String, dynamic>)
          : null,
    );
  }
}
