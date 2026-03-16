import 'package:lanternchat/models/conversations/conversation.dart';
import 'package:lanternchat/models/users/contact.dart';

class _Field {
  static const String contact = 'contact';
  static const String conversation = 'conversation';
}

class ConversationTile {
  final Contact? contact;
  final Conversation? conversation;

  ConversationTile({
    required this.contact,
    required this.conversation,
  });

  factory ConversationTile.fromMap(Map<String, dynamic> map) {
    return ConversationTile(
      contact: Contact.fromMap(map[_Field.contact] as Map<String, dynamic>? ?? {}),
      conversation: Conversation.fromMap(map[_Field.conversation] as Map<String, dynamic>? ?? {}),
    );
  }

  // Map<String, dynamic> toMap() {
  //   return {
  //     _Field.contact: contact.toMap(),
  //     _Field.conversation: conversation.toMap(),
  //   };
  // }
}
