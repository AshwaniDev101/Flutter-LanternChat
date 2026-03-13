class SeenMessage {
  final String messageId;
  final List<String> seenBy;

  const SeenMessage({
    required this.messageId,
    required this.seenBy,
  });

  /// Create object from Map
  factory SeenMessage.fromMap(Map<String, dynamic> map) {
    return SeenMessage(
      messageId: map['messageId'] as String,
      seenBy: List<String>.from(map['seenBy'] ?? []),
    );
  }

  /// Convert object to Map
  Map<String, dynamic> toMap() {
    return {
      'messageId': messageId,
      'seenBy': seenBy,
    };
  }

  /// Create a copy with modifications
  SeenMessage copyWith({
    String? messageId,
    List<String>? seenBy,
  }) {
    return SeenMessage(
      messageId: messageId ?? this.messageId,
      seenBy: seenBy ?? this.seenBy,
    );
  }
}