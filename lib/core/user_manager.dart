import 'package:firebase_auth/firebase_auth.dart';

class UserManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // User? _user;

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
    print(credential.toString());
  }
}
