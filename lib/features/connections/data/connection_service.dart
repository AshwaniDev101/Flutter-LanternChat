import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/models/app_user.dart';

import '../../../core/providers/constant_providers.dart';



class ConnectionService {
  final FirebaseFirestore firestore;

  late final userRef = firestore.collection('users');

  ConnectionService({required this.firestore});

  Stream<List<AppUser>> getConnections(String uid) {
    final connectionRef = userRef.doc(uid).collection('connections');

    // Stream<A>  →  Stream<B>
    //  Converting  'Stream<QuerySnapshot<Map<String, dynamic>>>'
    //  into-stream 'Stream<List<Map<String, dynamic>>>'
    return connectionRef.snapshots().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      // List<QueryDocumentSnapshot>   ->   List<AppUser>
      return snapshot.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> document) {
        return AppUser.fromMap(document.data());
      }).toList();
    });
  }
}
