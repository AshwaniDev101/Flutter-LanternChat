import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/users/app_user.dart';
import '../data/auth_service.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});


final authStateProvider = StreamProvider<User?>((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final currentUserProvider = Provider<AppUser>((ref) {
  final auth = ref.watch(authStateProvider);

  final user = auth.asData?.value;

  if (user == null) {
    throw StateError("User accessed outside authenticated session");
  }

  return AppUser.fromFirebaseUser(user);
});

// final Provider<AppUser> currentUserProvider = Provider<AppUser>((ref) {
//   final authState = ref.watch(authStatusProvider);
//
//   final firebaseAuth = ref.watch(firebaseAuthProvider);
//
//   return authState.when(
//     data: (user) {
//       if (user == null) {
//         throw StateError('User not logged in');
//       }
//       return AppUser.fromFirebaseUser(user);
//     },
//     loading: () {
//       final cachedUser = firebaseAuth.currentUser;
//
//       // During app restart FirebaseAuth briefly enters a loading state before
//       // authStateChanges() emits the current user. To avoid throwing a StateError
//       // during that window, we temporarily return the locally cached FirebaseAuth provided through the `data` state.
//       if (cachedUser != null) {
//         return AppUser.fromFirebaseUser(cachedUser);
//       }
//
//       throw StateError('currentUserProvider accessed before auth ready');
//     },
//     error: (e, _) => throw e,
//   );
// });

// this is just so i don't have to handle a stream convert stream into final AsyncValue<User?> auth
final authStatusProvider = StreamProvider<User?>((ref) {
  final userStream = ref.watch(firebaseAuthProvider).authStateChanges();
  return userStream;
});

final authManagerProvider = Provider((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthService(auth);
});
