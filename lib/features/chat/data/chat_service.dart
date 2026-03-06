import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/users/app_user.dart';
import '../../../models/messages/message.dart';

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
    final messagesRef = _getMessageReference(conversationID);

    return messagesRef.snapshots().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> documents) {
        return Message.fromMap(documents.data());
      }).toList();
    });
  }

  void addChatString(String? conversationID, Message message) {
    final messagesRef = _getMessageReference(conversationID);

    messagesRef.add(message.toMap());
  }

  void deleteChat(String conversationID, String messageID) {
    final singleMessagesRef = _getMessageReference(conversationID).doc(messageID);

    singleMessagesRef.delete();
  }

  void editChat(String conversationID, String messageID, Message updatedMessage) {
    final singleMessagesRef = _getMessageReference(conversationID).doc(messageID);

    singleMessagesRef.update(updatedMessage.toMap());
  }

  void forwardChat(String conversationID, Message message, AppUser appUser) {
    final messagesRef = _getMessageReference(conversationID);

    messagesRef.add(message.toMap());
  }

  CollectionReference<Map<String, dynamic>> _getMessageReference(String? conversationID) {
    if (conversationID == null || conversationID.isEmpty) {
      // Create a new conversationID
      final convRef = firestore.collection(ChatServiceConstants.conversation).doc();

      final convID = convRef.id;

      return firestore
          .collection(ChatServiceConstants.conversation)
          .doc(convID)
          .collection(ChatServiceConstants.messages);
    }

    return firestore
        .collection(ChatServiceConstants.conversation)
        .doc(conversationID)
        .collection(ChatServiceConstants.messages);
  }
}
