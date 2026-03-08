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
  static const String lastSenderName = 'lastSenderName';
  static const String lastSenderPhotoUrl = 'lastSenderPhotoUrl';
  static const String lastMessageTime = 'lastMessageTime';
  static const String type = 'type';
}

class Conversation {
  final String id;
  final List<String> memberIds;

  final String lastMessagePreview;
  final String lastSenderId;
  final String lastSenderName;
  final String lastSenderPhotoUrl;
  final Timestamp lastMessageTime;

  final ConversationType type;

  Conversation({
    required this.id,
    required this.memberIds,
    required this.lastMessagePreview,
    required this.lastSenderId,
    required this.lastSenderName,
    required this.lastSenderPhotoUrl,
    required this.lastMessageTime,
    required this.type,
  });

  factory Conversation.summary({required Contact contact, required Message message}) {
    return Conversation(
      id: contact.conversationId,
      memberIds: [contact.uid, message.senderId],
      lastMessagePreview: message.text.toString(),
      lastSenderId: message.senderId,
      lastSenderName: message.senderId == contact.uid ? '${contact.name} (You)' : contact.name,
      lastSenderPhotoUrl: contact.photoURL,
      lastMessageTime: message.createdAt,
      type: ConversationType.solo,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      _Field.id: id,
      _Field.memberIds: memberIds,
      _Field.lastMessagePreview: lastMessagePreview,
      _Field.lastSenderId: lastSenderId,
      _Field.lastSenderName: lastSenderName,
      _Field.lastSenderPhotoUrl: lastSenderPhotoUrl,
      _Field.lastMessageTime: lastMessageTime,
      _Field.type: type.name,
    };
  }

  factory Conversation.fromMap(Map<String, dynamic> map) {
    return Conversation(
      id: map[_Field.id] ?? '',
      memberIds: List<String>.from(map[_Field.memberIds] ?? []),
      lastMessagePreview: map[_Field.lastMessagePreview] ?? '',
      lastSenderId: map[_Field.lastSenderId] ?? '',
      lastSenderName: map[_Field.lastSenderName] ?? '',
      lastSenderPhotoUrl: map[_Field.lastSenderPhotoUrl] ?? '',
      lastMessageTime: map[_Field.lastMessageTime] ?? Timestamp.now(),
      type: ConversationType.values.asNameMap()[map[_Field.type]] ?? ConversationType.solo,
    );
  }
}
