import 'package:lanternchat/models/messages/message.dart';
import 'package:lanternchat/models/messages/seen_message.dart';

class _Field {
  static const String contact = 'contact';
  static const String conversation = 'conversation';
}

class MessageTile {
  final Message message;
  final SeenMessage? seenMessage;

  MessageTile({
    required this.message,
    this.seenMessage,
  });

/*  factory MessageTile.fromMap(Map<String, dynamic> map) {
    return MessageTile(
      message: Message.fromMap(map[_Field.contact] as Map<String, dynamic>? ?? {}),
      seenMessage: SeenMessage.fromMap(map[_Field.conversation] as Map<String, dynamic>? ?? {}),
    );
  }*/

}
