import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class _ServiceConstants {
  static const String conversations = 'conversations';
  static const String uid = 'uid';
  static const String timestamp = 'timestamp';
  static const String typing = 'typing';
}

class TypingService {
  final FirebaseDatabase firebaseDatabase;

  TypingService(this.firebaseDatabase);

  Stream<DatabaseEvent> watchTyping({required String conversationId}) {
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
        .set({_ServiceConstants.uid: uid, _ServiceConstants.timestamp: ServerValue.timestamp});
  }
}
