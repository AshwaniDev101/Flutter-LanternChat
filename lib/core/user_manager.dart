import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  return UserManager();
});

class UserManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;



  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  /// Initialize GoogleSignIn with the required serverClientId for Android.
  /// Call this once, e.g., in main() after Firebase.initializeApp().
  Future<void> initializeGoogleSignIn() async {
    try {
      await _googleSignIn.initialize(
        serverClientId: '352733183524-lpcgkaktk59qifrgk1m2glh9h494s26n.apps.googleusercontent.com',
      );
      print('GoogleSignIn initialized successfully');
    } catch (e) {
      print('GoogleSignIn initialization failed: $e');
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      // Ensure initialization has occurred (safe to call multiple times)
      // If not initialized in main(), you may call initializeGoogleSignIn() here

      final GoogleSignInAccount? googleUser = await _googleSignIn.authenticate();

      if (googleUser == null) {
        return null; // User canceled sign-in
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

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
