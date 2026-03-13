
class SeenMessage {
  final String uid;
  final String seenMessageId;

  const SeenMessage({
    required this.uid,
    required this.seenMessageId,
  });

  /// Create object from Map
  factory SeenMessage.fromMap(Map<String, dynamic> map) {
    return SeenMessage(
      uid: map['uid'] as String,
      seenMessageId: map['seenMessageId'] as String,
    );
  }

  /// Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'seenMessageId': seenMessageId,
    };
  }

  /// Create a copy with modifications
  SeenMessage copyWith({
    String? uid,
    String? seenMessageId,
  }) {
    return SeenMessage(
      uid: uid ?? this.uid,
      seenMessageId: seenMessageId ?? this.seenMessageId,
    );
  }
}