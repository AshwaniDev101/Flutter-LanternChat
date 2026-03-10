import 'package:cloud_firestore/cloud_firestore.dart';

class _Field {
  static const String participantID = 'participantID';
  static const String lastReadMessageId = 'lastReadMessageId';
  static const String typingAt = 'typingAt';
}

class Participant {
  final String participantID;
  final String lastReadMessageId;
  final Timestamp typingAt;

  Participant({
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

  factory Participant.fromMap(Map<String, dynamic> map) {
    return Participant(
      participantID: map[_Field.participantID] ?? '',
      lastReadMessageId: map[_Field.lastReadMessageId] ?? '',
      typingAt: map[_Field.typingAt] ?? Timestamp.now(),
    );
  }
}
