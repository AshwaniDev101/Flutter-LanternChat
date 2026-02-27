import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lanternchat/models/app_user.dart';

class UserService {
  final FirebaseFirestore firestore;

  UserService({required this.firestore});

  void addAsNewUser({required AppUser appUser}) {
    final userRef = firestore.collection('users');
    userRef.doc(appUser.uid).set(appUser.toMap());
  }

  Future<AppUser?> fetchUser(String uid) async {
    try {

      print('=== Fetching user');
      final ref = firestore.collection('users');

      final snapshot = await ref.doc(uid).get();

      if (!snapshot.exists) {
        return null;
      }

      final data = snapshot.data();

      if (data == null) {
        return null;
      }

      print('=== got user ${data.toString()}');

      data['uid'] = uid;
      return AppUser.fromMap(data);
    } catch (e) {
      print("Error Could not get User $e");
      return null;
    }
  }

  void addConnection(String myUID, AppUser connection) {

    final ref = firestore.collection('users').doc(myUID).collection('connections');

    ref.doc(connection.uid).set(connection.toMap());
  }
}
