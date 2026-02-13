import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lanternchat/core/providers/auth_provider.dart';




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
      // Ensure initialization has occurred (safe to call multiple times)
      // If not initialized in main(), you may call initializeGoogleSignIn() here

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await _auth.signInWithCredential(credential);

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

  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
