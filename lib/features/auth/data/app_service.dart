import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/users/app_user.dart';

class AppService {
  final FirebaseFirestore firestore;

  AppService({required this.firestore});

  late final userRef = firestore.collection('users');


  void addAsNewUser({required AppUser appUser}) {

    userRef.doc(appUser.uid).set(appUser.toMap());
  }

  Future<AppUser?> fetchUser(String uid) async {
    try {


      final snapshot = await userRef.doc(uid).get();

      if (!snapshot.exists) {
        return null;
      }

      final data = snapshot.data();

      if (data == null) {
        return null;
      }


      return AppUser.fromMap(uid, data);
    } catch (e) {
      print("Error Could not get User $e");
      return null;
    }
  }

  void addConnection(String myUID, AppUser connection) {

    final ref = userRef.doc(myUID).collection('connections');

    ref.doc(connection.uid).set(connection.toMap());
  }
}
