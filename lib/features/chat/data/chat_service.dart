import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/conversations/conversation_meta.dart';
import 'package:lanternchat/models/conversations/enums/conversation_type.dart';

import '../../../models/conversations/conversation.dart';
import '../../../models/users/app_user.dart';
import '../../../models/messages/message.dart';
import '../../../models/users/contact.dart';

//  ================== Note Keep in mind =================
// Use docChanges change only what needed keep the app fast
// Track message delivery with hasPendingWrites (✔) Animate properly

class _ServiceConstants {
  static const String conversations = 'conversations';
  static const String messages = 'messages';
  static const String createdAt = 'createdAt';

}

class ChatService {
  final FirebaseFirestore firestore;

  ChatService({required this.firestore});

  Stream<List<Message>> chatStream(String conversationId) {

    final convDoc = firestore.collection(_ServiceConstants.conversations).doc(conversationId).collection(_ServiceConstants.messages);

    return convDoc.orderBy(_ServiceConstants.createdAt, descending: false).snapshots().map((
      QuerySnapshot<Map<String, dynamic>> snapshot,
    ) {
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> documents) {
        return Message.fromMap(documents.data());
      }).toList();
    });
  }

  Future<void> sendMessageTo({required Contact contact, required Message message}) async {
    // print("#### Sending message on ${contact.conversationId}, ${message.text}");
    final batch = firestore.batch();

    // create conversation doc with id

    final convDoc = firestore.collection(_ServiceConstants.conversations).doc(contact.conversationId);

    batch.set(convDoc, Conversation.summary(contact:contact,message: message).toMap());

    convDoc.collection(_ServiceConstants.messages).add(message.toMap());

    batch.commit();
  }

  //
  // void deleteMessage(String conversationID, String messageID) {
  //   final singleMessagesRef = _getMessagesReference(conversationId: conversationID).doc(messageID);
  //
  //   singleMessagesRef.delete();
  // }
  //
  // void editMessage(String conversationID, String messageID, Message updatedMessage) {
  //   final singleMessagesRef = _getMessagesReference(conversationId: conversationID).doc(messageID);
  //
  //   singleMessagesRef.update(updatedMessage.toMap());
  // }
  //
  // void forwardMessage(String conversationID, Message message, AppUser appUser) {
  //   final messagesRef = _getMessagesReference(conversationId: conversationID);
  //
  //   messagesRef.add(message.toMap());
  // }
  //
  // CollectionReference<Map<String, dynamic>> _getMessagesReference({required String conversationId}) {
  //   return firestore
  //       .collection(_ServiceConstants.conversations)
  //       .doc(conversationId)
  //       .collection(_ServiceConstants.messages);
  // }
  //
  // DocumentReference<Map<String, dynamic>> _getConversationsRef({required String conversationId}) {
  //   return firestore.collection(_ServiceConstants.conversations).doc(conversationId);
  // }
}
