import 'package:cloud_firestore/cloud_firestore.dart';

class _Field {
  static const String uid = 'uid';
  static const String lastSeenMessageId = 'lastSeenMessageId';
  static const String lastSeenIndex = 'lastSeenIndex';
  static const String seenAt = 'seenAt';
}

class SeenMessage {
  final String uid;
  final int lastSeenIndex;
  final Timestamp seenAt;
  final String lastSeenMessageId;

  const SeenMessage({
    required this.uid,
    required this.lastSeenIndex,
    required this.lastSeenMessageId,
    required this.seenAt,
  });

  Map<String, dynamic> toMap() {
    return {
      _Field.uid: uid,
      _Field.lastSeenIndex: lastSeenIndex,
      _Field.lastSeenMessageId: lastSeenMessageId,
      _Field.seenAt: seenAt,
    };
  }

  factory SeenMessage.fromMap(Map<String, dynamic> map) {
    return SeenMessage(
      uid: map[_Field.uid] as String,
      lastSeenIndex: map[_Field.lastSeenIndex] as int,
      lastSeenMessageId: map[_Field.lastSeenMessageId] as String,
      seenAt: map[_Field.seenAt] as Timestamp,
    );
  }

  SeenMessage copyWith({
    String? uid,
    int? lastSeenIndex,
    String? lastSeenMessageId,
    Timestamp? seenAt,
  }) {
    return SeenMessage(
      uid: uid ?? this.uid,
      lastSeenIndex: lastSeenIndex ?? this.lastSeenIndex,
      lastSeenMessageId: lastSeenMessageId ?? this.lastSeenMessageId,
      seenAt: seenAt ?? this.seenAt,
    );
  }
}