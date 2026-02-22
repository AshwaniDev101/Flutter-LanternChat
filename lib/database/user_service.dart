
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/extensions/extensions.dart';

class UserService {


  final _firestore = FirebaseFirestore.instance;


  void addAsNewUser(User user)
  {

    print("============== Trying to add user! ${user.displayName}");
    final userRef = _firestore.collection('users');
    userRef.add(user.toMap());
  }
}