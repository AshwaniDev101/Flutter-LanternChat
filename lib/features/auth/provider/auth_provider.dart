import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/users/app_user.dart';
import '../data/auth_service.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});


final currentUserProvider = Provider<AppUser>((ref) {
  final authState = ref.watch(authStatusProvider);

  return authState.when(
    data: (user) {
      if (user == null) {
        throw StateError('User not logged in');
      }
      return AppUser.fromFirebaseUser(user);
    },
    loading: () => throw StateError('Auth loading'),
    error: (e, _) => throw e,
  );
});

// this is just so i don't have to handle a stream convert stream into final AsyncValue<User?> auth
final authStatusProvider = StreamProvider<User?>((ref) {
  final userStream = ref.watch(firebaseAuthProvider).authStateChanges();
  return userStream;
});

final authManagerProvider = Provider((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthService(auth);
});
