import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/conversations/conversation.dart';

class _ServiceConstants {
  static const String conversations = 'conversations';
  static const String lastMessageTime = 'lastMessageTime';
  static const String memberIds = 'memberIds';
  static const String pairID = 'pairID';
}

class ConversationService {
  final FirebaseFirestore firestore;

  ConversationService({required this.firestore});

  Stream<List<Conversation>> conversationStream({required String memberId}) {
    return _getConversationsRef()
        .where(_ServiceConstants.memberIds, arrayContains: memberId)
        .orderBy(_ServiceConstants.lastMessageTime, descending: true)
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> snapshot) {
          return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> documents) {
            return Conversation.fromMap(documents.data());
          }).toList();
        });
  }

  Future<Conversation?> getConversationUsingPairId({required String pairId}) async {
    final snap = await _getConversationsRef().where(_ServiceConstants.pairID, isEqualTo: pairId).limit(1).get();

    if (snap.docs.isEmpty) {
      return null;
    }

    final data = snap.docs.first.data();

    return Conversation.fromMap(data);
  }

  Future<void> restoreConversation({required String conversationId, required String memberUid}) async {
    await _getConversationsRef().doc(conversationId).update({
      _ServiceConstants.memberIds: FieldValue.arrayUnion([memberUid]),
    });
  }

  Future<void> removeUser({required String conversationId, required String memberUid}) async {
    await _getConversationsRef().doc(conversationId).update({
      _ServiceConstants.memberIds: FieldValue.arrayRemove([memberUid]),
    });
  }

  Future<void> removeUserList({required Set<String> conversationIds, required String memberUid}) async {
    if (conversationIds.isEmpty) return;

    final batch = firestore.batch();
    for (final id in conversationIds) {
      final docRef = _getConversationsRef().doc(id);
      batch.update(docRef, {
        _ServiceConstants.memberIds: FieldValue.arrayRemove([memberUid]),
      });
    }
    await batch.commit();
  }

  CollectionReference<Map<String, dynamic>> _getConversationsRef() {
    return firestore.collection(_ServiceConstants.conversations);
  }

  // Future<void> updateLastConversation(String conversationId, Conversation conversation) async {
  //   _getConversationsRef().doc(conversationId).set(conversation.toMap(), SetOptions(merge: true));
  // }
  //
}
