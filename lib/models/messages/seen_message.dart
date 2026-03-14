class _Field {
  static const String uid = 'uid';
  static const String lastSeenMessageId = 'lastSeenMessageId';
}

class SeenMessage {
  final String uid;
  final String lastSeenMessageId;

  const SeenMessage({required this.lastSeenMessageId, required this.uid});

  /// Convert object to map for Firestore
  Map<String, dynamic> toMap() {
    return {_Field.uid: uid, _Field.lastSeenMessageId: lastSeenMessageId};
  }

  /// Create object from Firestore map
  factory SeenMessage.fromMap(Map<String, dynamic> map) {
    return SeenMessage(uid: map[_Field.uid] as String, lastSeenMessageId: map[_Field.lastSeenMessageId] as String);
  }

  /// Useful when updating values
  SeenMessage copyWith({String? uid, String? lastSeenMessageId}) {
    return SeenMessage(uid: uid ?? this.uid, lastSeenMessageId: lastSeenMessageId ?? this.lastSeenMessageId);
  }
}
