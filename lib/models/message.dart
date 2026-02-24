

import 'package:cloud_firestore/cloud_firestore.dart';

class Message{

  final String sender;
  final String message;
  final Timestamp timestamp;


  Message({required this.sender, required this.message, required this.timestamp});
}