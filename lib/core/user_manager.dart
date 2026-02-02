import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStatusProvider = StreamProvider<User?>((ref) {
  // final userStream = ref.watch(firebaseAuthProvider).userChanges();
  final userStream = ref.watch(firebaseAuthProvider).authStateChanges();

  return userStream;
});

final userManagerProvider = Provider((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return UserManager(auth);
});

class UserManager {
  final FirebaseAuth _auth;

  UserManager(this._auth);

  void signInEmailPassword(String email, String password) async {
    final UserCredential credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    print(credential.toString());
  }

  void signUpEmailPassword(String email, String password) async {
    final UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    print(credential.toString());
  }

  void signInAnonymously() async {
    final UserCredential credential = await _auth.signInAnonymously();

    final user = credential.user;
    print(credential.toString());
  }


  void userLogout()
  {

  }
}
