import 'package:firebase_database/firebase_database.dart';

import '../../../models/users/user_presence.dart';

class _ServiceConstants {
  static const String users = 'users';
  static const String onlineStatus = 'onlineStatus';

  static const String uid = 'uid';
  static const String isOnline = 'isOnline';
  static const String lastSeen = 'lastSeen';
}

class PresenceService {
  final FirebaseDatabase firebaseDatabase;

  PresenceService({required this.firebaseDatabase});

  Stream<Map<String, dynamic>> watchAllStatuses() {
    final ref = firebaseDatabase.ref().child(_ServiceConstants.users).child(_ServiceConstants.onlineStatus);

    return ref.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data == null) return {};

      return data.map((key, value) {
        return MapEntry(key as String, Map<String, dynamic>.from(value));
      });
    });
  }

  Stream<Map<String, dynamic>?> watchUserStatus(String uid) {
    final ref = firebaseDatabase
        .ref()
        .child(_ServiceConstants.users)
        .child(_ServiceConstants.onlineStatus)
        .child(uid);

    return ref.onValue.map((event) {
      final data = event.snapshot.value;

      if (data == null) return null;

      return Map<String, dynamic>.from(data as Map);
    });
  }

  Future<void> setOnlineStatus({required String uid, required bool isOnline}) async {
    final ref = firebaseDatabase.ref().child(_ServiceConstants.users).child(_ServiceConstants.onlineStatus).child(uid);

    final onDisconnect = ref.onDisconnect();

    // Auto Offline
    await onDisconnect.set({
      _ServiceConstants.uid: uid,
      _ServiceConstants.isOnline: false,
      _ServiceConstants.lastSeen: ServerValue.timestamp,
    });

    // Set Online
    await ref.set({
      _ServiceConstants.uid: uid,
      _ServiceConstants.isOnline: isOnline,
      _ServiceConstants.lastSeen: ServerValue.timestamp,
    });

    print(watchAllStatuses());
  }

  // void listener(String uid)
  // {
  //   final connectedRef =
  //   FirebaseDatabase.instance.ref(".info/connected");
  //
  //   connectedRef.onValue.listen((event) async {
  //     final isConnected = event.snapshot.value as bool? ?? false;
  //
  //     if (isConnected) {
  //       await setOnlineStatus(uid: uid);
  //     }
  //   });
  // }
}
