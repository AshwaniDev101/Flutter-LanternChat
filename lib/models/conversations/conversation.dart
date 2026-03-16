import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/conversations/enums/conversation_type.dart';
import 'package:lanternchat/models/messages/message.dart';

import 'group_info.dart';

class _Field {
  static const String conversationId = 'conversationId';
  static const String memberIds = 'memberIds';
  static const String lastMessagePreview = 'lastMessagePreview';
  static const String lastSenderId = 'lastSenderId';
  static const String lastMessageTime = 'lastMessageTime';
  static const String conversationType = 'conversationType';
  static const String pairID = 'pairID';
  static const String lastMessageIndex = 'lastMessageIndex';
  static const String groupInfo = 'groupInfo';
}

class Conversation {
  final String conversationId;

  final Set<String> memberIds;
  final ConversationType conversationType;

  final String lastMessagePreview;
  final int lastMessageIndex;
  final String lastSenderId;
  final Timestamp lastMessageTime;

  final String? pairID;
  final GroupInfo? groupInfo;

  Conversation({
    required this.conversationId,
    required this.memberIds,
    required this.conversationType,
    required this.lastMessagePreview,
    required this.lastMessageIndex,
    required this.lastSenderId,
    required this.lastMessageTime,

    this.pairID,
    this.groupInfo,
  });

  /// Creates a new conversation summary after a message is sent
  factory Conversation.summary({required Conversation conversation, required Message message}) {
    return Conversation(
      conversationId: conversation.conversationId,
      memberIds: conversation.memberIds,
      conversationType: conversation.conversationType,
      lastMessagePreview: message.text ?? '',
      lastMessageIndex: message.messageIndex,
      lastSenderId: message.senderId,
      lastMessageTime: message.createdAt,
      pairID: conversation.pairID,
      groupInfo: conversation.groupInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _Field.conversationId: conversationId,
      _Field.memberIds: memberIds,
      _Field.conversationType: conversationType.name,
      _Field.lastMessagePreview: lastMessagePreview,
      _Field.lastMessageIndex: lastMessageIndex,
      _Field.lastSenderId: lastSenderId,
      _Field.lastMessageTime: lastMessageTime,
      _Field.pairID: pairID,
      _Field.groupInfo: groupInfo?.toMap(),
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      conversationId: map[_Field.conversationId] ?? '',
      memberIds: Set<String>.from(map[_Field.memberIds] ?? []),
      conversationType: ConversationType.values.asNameMap()[map[_Field.conversationType]] ?? ConversationType.solo,
      lastMessagePreview: map[_Field.lastMessagePreview] ?? '',
      lastMessageIndex: map[_Field.lastMessageIndex] ?? 0,
      lastSenderId: map[_Field.lastSenderId] ?? '',
      lastMessageTime: map[_Field.lastMessageTime] ?? Timestamp.now(),

      pairID: map[_Field.pairID],
      groupInfo: map[_Field.groupInfo] != null
          ? GroupInfo.fromMap(Map<String, dynamic>.from(map[_Field.groupInfo]))
          : null,
    );
  }

  Conversation copyWith({
    String? lastMessagePreview,
    int? lastMessageIndex,
    String? lastSenderId,
    Timestamp? lastMessageTime,
    GroupInfo? groupInfo,
  }) {
    return Conversation(
      conversationId: conversationId,
      memberIds: memberIds,
      conversationType: conversationType,
      pairID: pairID,
      lastMessagePreview: lastMessagePreview ?? this.lastMessagePreview,
      lastMessageIndex: lastMessageIndex ?? this.lastMessageIndex,
      lastSenderId: lastSenderId ?? this.lastSenderId,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      groupInfo: groupInfo ?? this.groupInfo,
    );
  }
}
