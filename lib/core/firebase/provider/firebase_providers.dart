import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/firestore_service.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final realtimeDbProvider = Provider<FirebaseDatabase>((ref) {
  return FirebaseDatabase.instance;
});


final firestoreServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FireStoreService(firestore: firestore);
});
