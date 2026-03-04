import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String sender;
  final String message;
  final Timestamp timestamp;

  Message({required this.sender, required this.message, required this.timestamp});

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(sender: map['sender'], message: map['messages'], timestamp: map['timestamp']);
  }

  Map<String, dynamic> toMap() {
    return {'sender': sender, 'message': message, 'timestamp': timestamp};
  }
}
