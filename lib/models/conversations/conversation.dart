import 'package:cloud_firestore/cloud_firestore.dart';

import 'conversation_meta.dart';
import 'enums/conversation_type.dart';

class _Field {
  static const String id = 'id';
  static const String memberIds = 'memberIds';
  static const String lastMessagePreview = 'lastMessagePreview';
  static const String lastSenderId = 'lastSenderId';
  static const String lastMessageTime = 'lastMessageTime';
  static const String type = 'type';
}

class Conversation {
  final String id;
  final List<String> memberIds;

  final String lastMessagePreview;
  final String lastSenderId;
  final Timestamp lastMessageTime;

  final ConversationType type;

  Conversation({
    required this.id,
    required this.memberIds,
    required this.lastMessagePreview,
    required this.lastSenderId,
    required this.lastMessageTime,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      _Field.id: id,
      _Field.memberIds: memberIds,
      _Field.lastMessagePreview: lastMessagePreview,
      _Field.lastSenderId: lastSenderId,
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
      lastMessageTime: map[_Field.lastMessageTime] ?? Timestamp.now(),
      type: ConversationType.values.asNameMap()[map[_Field.type]] ?? ConversationType.solo,
    );
  }
}
