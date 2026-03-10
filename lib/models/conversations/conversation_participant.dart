import 'package:cloud_firestore/cloud_firestore.dart';

class _Field {
  static const String participantID = 'participantID';
  static const String lastReadMessageId = 'lastReadMessageId';
  static const String unread = 'unread';
  static const String typingAt = 'typingAt';
  static const String pinned = 'pinned';
  static const String archived = 'archived';
  static const String muted = 'muted';
  static const String deletedAt = 'deletedAt';
  static const String joinedAt = 'joinedAt';
  static const String lastSeen = 'lastSeen';
}

class ConversationParticipant {
  final String participantID;
  final String lastReadMessageId;
  final Timestamp typingAt;

  ConversationParticipant({
    required this.participantID,
    required this.lastReadMessageId,
    required this.typingAt,
  });

  Map<String, dynamic> toMap() {
    return {
      _Field.participantID: participantID,
      _Field.lastReadMessageId: lastReadMessageId,

      _Field.typingAt: typingAt,
    };
  }

  factory ConversationParticipant.fromMap(Map<String, dynamic> map) {
    return ConversationParticipant(
      participantID: map[_Field.participantID] ?? '',
      lastReadMessageId: map[_Field.lastReadMessageId] ?? '',
      typingAt: map[_Field.typingAt] ?? Timestamp.now(),
    );
  }
}
