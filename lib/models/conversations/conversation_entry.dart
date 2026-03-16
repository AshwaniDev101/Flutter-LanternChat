import 'package:lanternchat/models/conversations/conversation.dart';
import 'package:lanternchat/models/users/contact.dart';

class _Field {
  static const String contact = 'contact';
  static const String conversation = 'conversation';
}

class ConversationEntry {
  final Contact? contact;
  final Conversation? conversation;

  ConversationEntry({
    required this.contact,
    required this.conversation,
  });

  factory ConversationEntry.fromMap(Map<String, dynamic> map) {
    return ConversationEntry(
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
