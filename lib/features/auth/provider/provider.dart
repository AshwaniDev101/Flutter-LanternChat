import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/providers/constant_providers.dart';

import '../../../models/users/app_user.dart';
import '../../../core/firestore/data/firestore_service.dart';
import '../auth_manager.dart';


final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});


final currentUserProvider = Provider<AppUser>((ref) {
  final User? currentUser = ref.watch(firebaseAuthProvider).currentUser;

  if (currentUser == null) {
    throw Exception("User can't be null something went wrong");
    // ref.watch(goRouterProvider).go(AppRoute.login);
  }
  return AppUser.fromFirebaseUser(currentUser);
});


// this is just so i don't have to handle a stream convert stream into final AsyncValue<User?> auth
final authStatusProvider = StreamProvider<User?>((ref) {
  final userStream = ref.watch(firebaseAuthProvider).authStateChanges();
  return userStream;
});

final authManagerProvider = Provider((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthManager(auth);
});
