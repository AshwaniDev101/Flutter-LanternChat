import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/app_user.dart';
import '../../../models/message.dart';

//  ================== Note Keep in mind =================
// Use docChanges change only what needed keep the app fast
// Track message delivery with hasPendingWrites (✔) Animate properly

class ChatServiceConstants {
  static const String conversation = 'conversation';
  static const String messages = 'messages';
}

class ChatService {
  final FirebaseFirestore firestore;

  ChatService({required this.firestore});

  Stream<List<Message>> chatStream(String conversationID) {
    final messagesRef = getMessageReference(conversationID);

    return messagesRef.snapshots().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> documents) {
        return Message.fromMap(documents.data());
      }).toList();
    });
  }

  void addChatString(String conversationID, Message message) {
    final messagesRef = getMessageReference(conversationID);

    messagesRef.add(message.toMap());
  }

  void deleteChat(String conversationID, String messageID) {
    final singleMessagesRef = getMessageReference(conversationID).doc(messageID);

    singleMessagesRef.delete();
  }

  void editChat(String conversationID, String messageID, Message updatedMessage) {
    final singleMessagesRef = getMessageReference(conversationID).doc(messageID);

    singleMessagesRef.update(updatedMessage.toMap());
  }

  void forwardChat(String conversationID, Message message, AppUser appUser) {
    final messagesRef = getMessageReference(conversationID);

    messagesRef.add(message.toMap());
  }

  CollectionReference<Map<String, dynamic>> getMessageReference(String conversationID) {
    return firestore
        .collection(ChatServiceConstants.conversation)
        .doc(conversationID)
        .collection(ChatServiceConstants.messages);
  }
}
