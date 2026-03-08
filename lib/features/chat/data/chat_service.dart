import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/conversations/conversation_meta.dart';
import 'package:lanternchat/models/conversations/enums/conversation_type.dart';

import '../../../models/users/app_user.dart';
import '../../../models/messages/message.dart';

//  ================== Note Keep in mind =================
// Use docChanges change only what needed keep the app fast
// Track message delivery with hasPendingWrites (✔) Animate properly

class _ServiceConstants {
  static const String conversations = 'conversations';
  static const String messages = 'messages';
  static const String createdAt = 'createdAt';
  static const String users = 'users';
}

class ChatService {
  final FirebaseFirestore firestore;

  ChatService({required this.firestore});

  Stream<List<Message>> chatStream(String conversationId) {
    final messagesRef = _getMessagesReference(conversationId: conversationId);

    return messagesRef.orderBy(_ServiceConstants.createdAt, descending: false).snapshots().map((
      QuerySnapshot<Map<String, dynamic>> snapshot,
    ) {
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> documents) {
        return Message.fromMap(documents.data());
      }).toList();
    });
  }

  Future<void> sendMessage(String conversationId, Message message) async {
    final batch = firestore.batch();

    final messagesRef = _getMessagesReference(conversationId: conversationId);

    batch.set(messagesRef.doc(), message.toMap());

    final conversationRef = _getConversationsRef(conversationId: conversationId);

    batch.update(conversationRef, message.toSummary(conversationId));
  }

  void deleteMessage(String conversationID, String messageID) {
    final singleMessagesRef = _getMessagesReference(conversationId: conversationID).doc(messageID);

    singleMessagesRef.delete();
  }

  void editMessage(String conversationID, String messageID, Message updatedMessage) {
    final singleMessagesRef = _getMessagesReference(conversationId: conversationID).doc(messageID);

    singleMessagesRef.update(updatedMessage.toMap());
  }

  void forwardMessage(String conversationID, Message message, AppUser appUser) {
    final messagesRef = _getMessagesReference(conversationId: conversationID);

    messagesRef.add(message.toMap());
  }

  CollectionReference<Map<String, dynamic>> _getMessagesReference({required String conversationId}) {
    return firestore
        .collection(_ServiceConstants.conversations)
        .doc(conversationId)
        .collection(_ServiceConstants.messages);
  }

  DocumentReference<Map<String, dynamic>> _getConversationsRef({required String conversationId}) {
    return firestore.collection(_ServiceConstants.conversations).doc(conversationId);
  }
}
