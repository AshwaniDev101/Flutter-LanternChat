import 'package:cloud_firestore/cloud_firestore.dart';

import 'message.dart';

enum ConversationsType { group, solo }

enum ConversationsRole { admin, moderator }

class _Field {
  static const String name = 'name';
  static const String imageUrl = 'imageUrl';
  static const String description = 'description';
  static const String createdBy = 'createdBy';

  static const String participantID = 'participantID';
  static const String lastReadMessageId = 'lastReadMessageId';
  static const String unread = 'unread';
  static const String typing = 'typing';
  static const String pinned = 'pinned';
  static const String archived = 'archived';
  static const String muted = 'muted';
  static const String deletedAt = 'deletedAt';
  static const String joinedAt = 'joinedAt';
  static const String lastSeen = 'lastSeen';

  static const String conversationsId = 'conversationsId';
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

class GroupInfo {
  final String name;
  final String imageUrl;
  final String description;
  final String createdBy;

  GroupInfo({required this.name, required this.imageUrl, required this.description, required this.createdBy});

  Map<String, dynamic> toMap() {
    return {
      _Field.name: name,
      _Field.imageUrl: imageUrl,
      _Field.description: description,
      _Field.createdBy: createdBy,
    };
  }

  factory GroupInfo.fromMap(Map<String, dynamic> map) {
    return GroupInfo(
      name: map[_Field.name] ?? '',
      imageUrl: map[_Field.imageUrl] ?? '',
      description: map[_Field.description] ?? '',
      createdBy: map[_Field.createdBy] ?? '',
    );
  }
}

class Participant {
  final String participantID;
  final String lastReadMessageId;
  final int unread;
  final bool typing;
  final bool pinned;
  final bool archived;
  final bool muted;
  final Timestamp deletedAt;
  final Timestamp joinedAt;
  final Timestamp lastSeen;

  Participant({
    required this.participantID,
    required this.lastReadMessageId,
    required this.unread,
    required this.typing,
    required this.pinned,
    required this.archived,
    required this.muted,
    required this.deletedAt,
    required this.joinedAt,
    required this.lastSeen,
  });

  Map<String, dynamic> toMap() {
    return {
      _Field.participantID: participantID,
      _Field.lastReadMessageId: lastReadMessageId,
      _Field.unread: unread,
      _Field.typing: typing,
      _Field.pinned: pinned,
      _Field.archived: archived,
      _Field.muted: muted,
      _Field.deletedAt: deletedAt,
      _Field.joinedAt: joinedAt,
      _Field.lastSeen: lastSeen,
    };
  }

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      participantID: map[_Field.participantID] ?? '',
      lastReadMessageId: map[_Field.lastReadMessageId] ?? '',
      unread: (map[_Field.unread] ?? 0).toInt(),
      typing: map[_Field.typing] ?? false,
      pinned: map[_Field.pinned] ?? false,
      archived: map[_Field.archived] ?? false,
      muted: map[_Field.muted] ?? false,
      deletedAt: map[_Field.deletedAt] ?? Timestamp.now(),
      joinedAt: map[_Field.joinedAt] ?? Timestamp.now(),
      lastSeen: map[_Field.lastSeen] ?? Timestamp.now(),
    );
  }
}

class Conversations {
  final String conversationsId;
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
    required this.conversationsId,
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
      _Field.conversationsId: conversationsId,
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
      conversationsId: map[_Field.conversationsId] ?? '',
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
      groupInfo: map[_Field.groupInfo] != null ? GroupInfo.fromMap(map[_Field.groupInfo] as Map<String, dynamic>) : null,
    );
  }
}
