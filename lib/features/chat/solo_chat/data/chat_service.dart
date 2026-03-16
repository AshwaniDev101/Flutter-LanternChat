import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/core/helpers/id_helper.dart';
import 'package:lanternchat/models/conversations/group_info.dart';

import '../../../../core/util/logger.dart';
import '../../../../models/conversations/conversation.dart';
import '../../../../models/conversations/enums/conversation_type.dart';
import '../../../../models/messages/message.dart';

class _ServiceConstants {
  static const String conversations = 'conversations';
  static const String messages = 'messages';
  static const String createdAt = 'createdAt';
  static const String seenBy = 'seenBy';
}

class ChatService {
  final FirebaseFirestore firestore;

  ChatService({required this.firestore});

  /// Returns a real-time stream of messages for a conversation.
  ///
  /// Firestore path:
  /// conversation(collection)/conversationId(doc)/messages(collection)
  ///
  /// Messages are ordered by 'createdAt' in ascending order
  /// so the chat appears from oldest → newest.
  Stream<List<Message>> watchChatStream(String conversationId) {
    final convDoc = _getConversationsRef().doc(conversationId).collection(_ServiceConstants.messages);

    return convDoc.orderBy(_ServiceConstants.createdAt, descending: false).snapshots().map((
      QuerySnapshot<Map<String, dynamic>> snapshot,
    ) {
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> document) {
        return Message.fromMap(document.id, document.data());
      }).toList();
    });
  }

  /// Sends a message to an existing conversation.
  ///
  /// This performs a batched write that:
  /// 1. Updates the conversation summary (last message preview, sender, timestamp)
  /// 2. Adds the message to "conversations/{conversationId}/messages"
  Future<void> sendMessageTo({required String conversationId, required Message message}) async {
    await firestore.runTransaction((transaction) async {
      // create conversation doc with id
      final conversationDocRef = _getConversationsRef().doc(conversationId);


      final conversationSnapshot = await transaction.get(conversationDocRef);

      final doc = conversationSnapshot.data();
      if (doc != null) {
        final convo = Conversation.fromMap(doc);

        // incrementing message index
        final newMessageIndex = convo.lastMessageIndex +1 ;

        final messageDocRef = conversationDocRef.collection(_ServiceConstants.messages).doc();

        final updatedMessage = message.copyWith(messageId: messageDocRef.id, messageIndex: newMessageIndex);

        // Adding conversation summary to conversation collection
        transaction.set(conversationDocRef, Conversation.summary(conversation: convo, message: updatedMessage).toMap());

        transaction.set(messageDocRef, updatedMessage.toMap());
      } else {
        throw Exception("sendMessageTo: Conversation does not exist");
      }
    });
  }

  /// Creates a new conversation and sends the first message.
  ///
  /// This is used when no conversation exists between the users yet.
  /// A new 'conversationId' is generated, the conversation summary is
  /// created, and the first message is inserted into the 'messages'
  /// subcollection using a batched write.
  ///
  /// Firestore structure:
  /// conversations/{conversationId}
  /// conversations/{conversationId}/messages/{messageId}
  Future<Conversation> sendMessageToNewConversation({
    required Message message,
    required String senderUid,
    required String receiverUid,
  }) async {
    final batch = firestore.batch();

    final conversationRef = _getConversationsRef().doc();

    // Creates new id
    final newGeneratedConversationID = conversationRef.id;

    // Creating a new conversation
    final newlyCreateConversationSummary = Conversation(
      conversationId: newGeneratedConversationID,
      memberIds: {senderUid, receiverUid},
      conversationType: ConversationType.solo,
      pairID: IdHelper.generatePairId(senderUid, receiverUid),
      lastMessagePreview: message.text.toString(),
      lastMessageIndex: 0,
      lastSenderId: senderUid,
      lastMessageTime: Timestamp.now(),
    );
    // add conversation summary to conversation collection
    batch.set(conversationRef, newlyCreateConversationSummary.toMap());

    // setting messages(collection) ref and adding message to it
    final messagesRef = conversationRef.collection(_ServiceConstants.messages).doc();
    batch.set(messagesRef, message.toMap());

    await batch.commit();

    return newlyCreateConversationSummary;
  }


  Future<String> createGroupChat({

    required GroupInfo groupInfo, required Set<String> memberIds,
  }) async {

    final conversationRef = _getConversationsRef().doc();

    // Creates new id
    final newGeneratedConversationID = conversationRef.id;

    // Creating a new conversation
    final newlyCreatedGroupConversation = Conversation(
      conversationId: newGeneratedConversationID,
      memberIds: memberIds,
      conversationType: ConversationType.group,
      pairID: null,
      lastMessagePreview: '${groupInfo.createdBy.name} create group',
      lastMessageIndex: 0,
      lastSenderId: groupInfo.createdBy.uid,
      lastMessageTime: Timestamp.now(),
      groupInfo: groupInfo,
    );


    AppLogger.i('CreateGroupChat ${groupInfo.title}');
    conversationRef.set(newlyCreatedGroupConversation.toMap());

    return newGeneratedConversationID;
  }



  /// Marks a message as seen by a specific user.
  ///
  /// Updates the 'seenBy' map inside the message document by adding
  /// the user's 'uid' with the current timestamp.
  ///
  /// Example structure:
  /// messages/{messageId}
  ///   seenBy:
  ///     {uid}: seenBy.toMap()

  void setMessageSeen(String conversationID, String messageID, String uid) {
    final singleMessagesRef = _getMessagesReference(conversationId: conversationID).doc(messageID);

    // In Firestore updates, the dot is used for nested map field access.
    singleMessagesRef.update({'${_ServiceConstants.seenBy}.$uid': Timestamp.now()});
  }

  CollectionReference<Map<String, dynamic>> _getConversationsRef() {
    return firestore.collection(_ServiceConstants.conversations);
  }

  CollectionReference<Map<String, dynamic>> _getMessagesReference({required String conversationId}) {
    return firestore
        .collection(_ServiceConstants.conversations)
        .doc(conversationId)
        .collection(_ServiceConstants.messages);
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
