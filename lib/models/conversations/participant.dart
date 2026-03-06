import 'package:cloud_firestore/cloud_firestore.dart';

class _Field {
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
