import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class UserPresence {
  final String uid;
  final Timestamp lastSeen;
  final bool isOnline;

  UserPresence({
    required this.uid,
    required this.lastSeen,
    required this.isOnline,
  });

  factory UserPresence.fromMap(Map<String, dynamic> map) {
    return UserPresence(

      uid: map['uid'] as String? ?? '' ,
      lastSeen: map['lastSeen'] as Timestamp? ?? Timestamp.now(),
      isOnline: map['isOnline'] as bool? ?? false,
    );
  }

  // Map<String, dynamic> toMap({required bool? isOnline}) {
  //   return {
  //     'uid': uid,
  //     'lastSeen': lastSeen,
  //     'isOnline': isOnline ?? this.isOnline,
  //   };
  // }

  Map<String, dynamic> toRealtimeMap({required bool isOnline}) {
    return {
      'uid': uid,
      'isOnline': isOnline,
      'lastSeen': ServerValue.timestamp,
    };
  }

  // Map<String, dynamic> toOnlineMap() {
  //   return {
  //     'uid': uid,
  //     'lastSeen': lastSeen,
  //     'isOnline': true,
  //   };
  // }
  //
  // Map<String, dynamic> toOfflineMap() {
  //   return {
  //     'uid': uid,
  //     'lastSeen': lastSeen,
  //     'isOnline': false,
  //   };
  // }
}