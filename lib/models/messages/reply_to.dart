

import 'enums/message_type.dart';

class _Field {
  static const String messageId = 'messageId';
  static const String senderId = 'senderId';
  static const String messageType = 'messageType';
  static const String text = 'text';
}

class ReplyTo {
  final String messageId;
  final String senderId;
  final MessageType messageType;
  final String text;

  ReplyTo({required this.messageId, required this.senderId, required this.text, required this.messageType});

  Map<String, dynamic> toMap() {
    return {
      _Field.messageId: messageId,
      _Field.senderId: senderId,
      _Field.messageType: messageType.name,
      _Field.text: text,
    };
  }

  factory ReplyTo.fromMap(Map<String, dynamic> map) {
    return ReplyTo(
      messageId: map[_Field.messageId] ?? '',
      senderId: map[_Field.senderId] ?? '',
      messageType: MessageType.values.asNameMap()[map[_Field.messageType]] ?? MessageType.text,
      text: map[_Field.text] ?? '',
    );
  }
}
