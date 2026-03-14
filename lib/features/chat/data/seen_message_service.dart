import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/messages/seen_message.dart';


class _ServiceConstants {
  static const String conversations = 'conversations';
  static const String seenMessages = 'seenMessages';
  static const String createdAt = 'createdAt';
}

class SeenMessageService {
  // final FirebaseDatabase firebaseDatabase;
  // SeenMessageService(this.firebaseDatabase);

  final FirebaseFirestore firestore;

  SeenMessageService({required this.firestore});

  Stream<List<SeenMessage>> watchSeenMessageStream(String conversationId) {
    final convDoc = _getConversationsRef().doc(conversationId).collection(_ServiceConstants.seenMessages);

    return convDoc.orderBy(_ServiceConstants.createdAt, descending: false).snapshots().map((
      QuerySnapshot<Map<String, dynamic>> snapshot,
    ) {
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> documents) {
        return SeenMessage.fromMap(documents.data());
      }).toList();
    });
  }

  /// Sent message to conversationId as well updates the conversation summary
  Future<void> setMessageSeen({required String conversationId, required SeenMessage seemMessage}) async {
    final convRef = _getConversationsRef().doc(conversationId).collection(_ServiceConstants.seenMessages);
    convRef.doc(seemMessage.uid).set(seemMessage.toMap());
  }

  CollectionReference<Map<String, dynamic>> _getConversationsRef() {
    return firestore.collection(_ServiceConstants.conversations);
  }

}
