import 'package:cloud_firestore/cloud_firestore.dart';



//  ================== Note Keep in mind =================
// Use docChanges change only what needed keep the app fast
// Track message delivery with hasPendingWrites (✔) Animate properly
class ChatService {
  final FirebaseFirestore firestore;

  ChatService({required this.firestore});
}
