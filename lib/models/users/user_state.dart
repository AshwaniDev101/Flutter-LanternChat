import 'package:cloud_firestore/cloud_firestore.dart';

class UserState {
  final Timestamp lastSeen;
  final bool isOnline;

  UserState({required this.lastSeen, required this.isOnline});
}
