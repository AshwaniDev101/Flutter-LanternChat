import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/users/app_user.dart';

class FireStoreService {
  final FirebaseFirestore firestore;

  FireStoreService({required this.firestore});

  late final userRef = firestore.collection('users');


  void addAsNewUser({required AppUser appUser}) {

    userRef.doc(appUser.uid).set(appUser.toMap());
  }


}
