import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';


import 'constant_providers.dart';

final userManagerProvider = Provider((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return UserManager(auth);
});

class UserManager {
  final FirebaseAuth _auth;

  UserManager(this._auth);

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<User?> signInWithGoogle() async {
    try {
      // This triggers Google Account Picker
      final GoogleSignInAccount googleAccount = await _googleSignIn.authenticate();

      // Gets ID token. Proof this user authenticated.
      final GoogleSignInAuthentication googleAuth = googleAccount.authentication;

      // Creates Firebase credential.
      final OAuthCredential oAuthCredential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);

      // Signs into Firebase using Googles oAuthCredential. And return firebase userCredential
      final UserCredential userCredential = await _auth.signInWithCredential(oAuthCredential);

      return userCredential.user;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  // Stream<User?> get authStateChanges => _auth.authStateChanges();
}
