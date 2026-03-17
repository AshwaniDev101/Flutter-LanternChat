import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/auth/data/presence_service.dart';
import 'package:lanternchat/models/users/user_presence.dart';

import '../../../core/firebase/provider/firebase_providers.dart';

final Provider<PresenceService> presenceServiceProvider = Provider((ref) {
  final firebaseDatabase = ref.watch(firebaseDatabaseProvider);
  return PresenceService(firebaseDatabase: firebaseDatabase);
});

final StreamProvider<Map<String, dynamic>> presenceMapStreamProvider = StreamProvider<Map<String, dynamic>>((ref) {
  final service = ref.watch(presenceServiceProvider);
  return service.watchAllStatuses();
});

final Provider<Map<String, UserPresence>> presenceMapProvider = Provider<Map<String, UserPresence>>((ref) {
  final asyncValue = ref.watch(presenceMapStreamProvider);

  final data = asyncValue.value ?? {};

  return data.map((uid, map) {
    return MapEntry(
      uid,
      UserPresence(
        uid: uid,
        isOnline: map['isOnline'] ?? false,
        lastSeen: Timestamp.fromMillisecondsSinceEpoch(map['lastSeen'] ?? 0),
      ),
    );
  });
});

// final StreamProviderFamily<Map<String, dynamic>?, String> userPresenceProvider = StreamProvider.family<Map<String, dynamic>?, String>((ref, uid) {
//   final presenceService = ref.watch(presenceServiceProvider);
//   return presenceService.watchUserStatus(uid);
// });
