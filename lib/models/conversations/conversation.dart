import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/messages/message.dart';
import 'package:lanternchat/models/users/contact.dart';

import 'conversation_meta.dart';
import 'enums/conversation_type.dart';

class _Field {
  static const String id = 'id';
  static const String memberIds = 'memberIds';
  static const String lastMessagePreview = 'lastMessagePreview';
  static const String lastSenderId = 'lastSenderId';
  static const String lastMessageTime = 'lastMessageTime';

}

class Conversation {
  final String id;
  final List<String> memberIds;
  final String lastMessagePreview;
  final String lastSenderId;
  final Timestamp lastMessageTime;

  Conversation({
    required this.id,
    required this.memberIds,
    required this.lastMessagePreview,
    required this.lastSenderId,
    required this.lastMessageTime,
  });

  factory Conversation.summary({required Contact contact, required Message message}) {
    return Conversation(
      id: contact.conversationId,
      memberIds: [contact.uid, message.senderId],
      lastMessagePreview: message.text.toString(),
      lastSenderId: message.senderId,
      lastMessageTime: message.createdAt,

    );
  }

  Map<String, dynamic> toMap() {
    return {
      _Field.id: id,
      _Field.memberIds: memberIds,
      _Field.lastMessagePreview: lastMessagePreview,
      _Field.lastSenderId: lastSenderId,
      _Field.lastMessageTime: lastMessageTime,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map[_Field.id] ?? '',
      memberIds: List<String>.from(map[_Field.memberIds] ?? []),
      lastMessagePreview: map[_Field.lastMessagePreview] ?? '',
      lastSenderId: map[_Field.lastSenderId] ?? '',
      lastMessageTime: map[_Field.lastMessageTime] ?? Timestamp.now(),
    );
  }
}
