import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/core/helpers/id_helper.dart';

import '../../../models/conversations/conversation.dart';
import '../../../models/conversations/conversation_tile.dart';
import '../../../models/conversations/enums/conversation_type.dart';
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

  Stream<List<Message>> watchChatStream(String conversationId) {
    final convDoc = _getConversationsRef().doc(conversationId).collection(_ServiceConstants.messages);

    return convDoc.orderBy(_ServiceConstants.createdAt, descending: false).snapshots().map((
      QuerySnapshot<Map<String, dynamic>> snapshot,
    ) {
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> documents) {
        return Message.fromMap(documents.data());
      }).toList();
    });
  }


  /// Sent message to conversationId as well updates the conversation summary
  Future<void> sendMessageTo({required Conversation conversation, required Message message}) async {
    // print("#### Sending message on ${contact.conversationId}, ${message.text}");
    final batch = firestore.batch();

    // create conversation doc with id

    final convDoc = _getConversationsRef().doc(conversation.conversationId);

    batch.set(convDoc, Conversation.summary(conversation: conversation, message: message).toMap());

    convDoc.collection(_ServiceConstants.messages).add(message.toMap());

    batch.commit();
  }

  // Future<Conversation> createConversation({
  //   required List<String> memberIds,
  //   required ConversationType conversationType,
  //   String? pairId,
  // }) async {
  //
  //
  //   return conversation;
  // }

  /// Sent message to conversationId as well updates the conversation summary
  Future<Conversation> sendMessageToConversation({
    required Message message,
    required String senderUid,
    required String sentToUid
  }) async {
    // print("#### Sending message on ${contact.conversationId}, ${message.text}");
    final batch = firestore.batch();

    // create conversation doc with id

    final docRef = _getConversationsRef().doc();

    final conversation = Conversation(
      conversationId: docRef.id,
      memberIds: [senderUid,sentToUid],
      conversationType: ConversationType.solo,
      pairID: IdHelper.generatePairId(senderUid, sentToUid),
      lastMessagePreview: message.text.toString(),
      lastSenderId: senderUid,
      lastMessageTime: Timestamp.now(),
    );

    batch.set(docRef, conversation.toMap());

    final convDoc = _getConversationsRef().doc(conversation.conversationId);

    batch.set(convDoc, Conversation.summary(conversation: conversation, message: message).toMap());

    convDoc.collection(_ServiceConstants.messages).add(message.toMap());

    batch.commit();

    return conversation;
  }

  CollectionReference<Map<String, dynamic>> _getConversationsRef() {
    return firestore.collection(_ServiceConstants.conversations);
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
  //   return firebase
  //       .collection(_ServiceConstants.conversations)
  //       .doc(conversationId)
  //       .collection(_ServiceConstants.messages);
  // }
  //
  // DocumentReference<Map<String, dynamic>> _getConversationsRef({required String conversationId}) {
  //   return firebase.collection(_ServiceConstants.conversations).doc(conversationId);
  // }
}
