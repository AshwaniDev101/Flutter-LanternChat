import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/conversations/conversation.dart';

class _ServiceConstants {
  static const String conversations = 'conversations';
  static const String lastMessageTime = 'lastMessageTime';
  static const String memberIds = 'memberIds';

}

class ConversationService {
  final FirebaseFirestore firestore;

  ConversationService({required this.firestore});

  Stream<List<Conversation>> conversationStream(String currentUserId) {
    return _getConversationsRef()
        .where(_ServiceConstants.memberIds, arrayContains: currentUserId)
        .orderBy(_ServiceConstants.lastMessageTime, descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
          return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> documents) {
            return Conversation.fromMap(documents.data());
          }).toList();
        });
  }

  // Future<void> updateLastConversation(String conversationId, Conversation conversation) async {
  //   _getConversationsRef().doc(conversationId).set(conversation.toMap(), SetOptions(merge: true));
  // }
  //
  CollectionReference<Map<String, dynamic>> _getConversationsRef() {
    return firestore.collection(_ServiceConstants.conversations);
  }
}
