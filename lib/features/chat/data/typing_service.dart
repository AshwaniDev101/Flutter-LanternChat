import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class _ServiceConstants {
  static const String conversations = 'conversations';
  static const String typing = 'typing';
  static const String lastSeenMessage = 'lastSeenMessage';
}

class TypingService {
  final FirebaseDatabase firebaseDatabase;

  TypingService(this.firebaseDatabase);



  Stream<DatabaseEvent> watchTyping({required String conversationId, required String uid}) {
    final ref = firebaseDatabase
        .ref()
        .child(_ServiceConstants.conversations)
        .child(conversationId)
        .child(_ServiceConstants.typing);

    return ref.onValue;
  }

  void sendData({required String conversationId, required String uid}) {
    firebaseDatabase
        .ref()
        .child(_ServiceConstants.conversations)
        .child(conversationId)
        .child(_ServiceConstants.typing)
        .set({uid: ServerValue.timestamp});
  }


}
