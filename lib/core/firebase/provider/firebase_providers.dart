import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/firestore_service.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firebaseDatabaseProvider = Provider<FirebaseDatabase>((ref) {

  return FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: "https://lanternchat-app-default-rtdb.asia-southeast1.firebasedatabase.app",
  );

});


final firestoreServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FirestoreService(firestore: firestore);
});
