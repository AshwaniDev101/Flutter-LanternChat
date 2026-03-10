import 'package:cloud_firestore/cloud_firestore.dart';

import 'enums/conversation_type.dart';
import 'group_info.dart';

class _Field {
  static const String pinned = 'pinned';
  static const String archived = 'archived';
  static const String muted = 'muted';
  static const String deletedAt = 'deletedAt';
  static const String joinedAt = 'joinedAt';

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

class ConversationPreference {
  final ConversationType conversationsType;
  final String hostId;

  final bool pinned;
  final bool archived;
  final bool muted;

  final Timestamp createdAt;
  final Timestamp joinedAt;
  final Timestamp deletedAt;

  final GroupInfo? groupInfo;

  ConversationPreference({
    required this.conversationsType,
    required this.hostId,

    required this.pinned,
    required this.archived,
    required this.muted,

    required this.createdAt,
    required this.joinedAt,
    required this.deletedAt,

    this.groupInfo,
  });

  Map<String, dynamic> toMap() {
    return {
      _Field.conversationsType: conversationsType,
      _Field.hostId: hostId,

      _Field.pinned: pinned,
      _Field.archived: archived,
      _Field.muted: muted,

      _Field.createdAt: createdAt,
      _Field.joinedAt: joinedAt,
      _Field.deletedAt: deletedAt,

      _Field.groupInfo: groupInfo?.toMap(),
    };
  }

  factory ConversationPreference.fromMap(Map<String, dynamic> map) {
    return ConversationPreference(
      conversationsType: ConversationType.values.asNameMap()[map[_Field.conversationsType]] ?? ConversationType.solo,

      hostId: map[_Field.hostId] ?? '',

      pinned: map[_Field.pinned] ?? false,
      archived: map[_Field.archived] ?? false,
      muted: map[_Field.muted] ?? false,

      createdAt: map[_Field.createdAt] ?? Timestamp.now(),
      joinedAt: map[_Field.joinedAt] ?? Timestamp.now(),
      deletedAt: map[_Field.deletedAt] ?? Timestamp.now(),

      groupInfo: map[_Field.groupInfo] != null
          ? GroupInfo.fromMap(Map<String, dynamic>.from(map[_Field.groupInfo]))
          : null,
    );
  }
}
