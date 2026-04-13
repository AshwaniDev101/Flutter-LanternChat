import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';


class AuthService {
  final FirebaseAuth _auth;

  AuthService(this._auth);

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<User?> signInWithGoogle() async {
    try {


      // Google Auth for web
      if (kIsWeb) {
        final provider = GoogleAuthProvider();

        final userCredential =
        await _auth.signInWithPopup(provider);

        return userCredential.user;
      }


      // This triggers Google Account Picker
      final GoogleSignInAccount googleAccount = await _googleSignIn.authenticate();

      // Gets ID token. Proof this users authenticated.
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
