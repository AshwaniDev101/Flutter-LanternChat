import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/extensions/extensions.dart';
import '../../core/providers/constant_providers.dart';

class UserService {
  final FirebaseFirestore firestore;

  UserService({required this.firestore});

  void addAsNewUser(User user) {
    print("============== Trying to add user! ${user.displayName}");
    final userRef = firestore.collection('users');

    userRef.doc(user.uid).set(user.toMap());
  }
}
