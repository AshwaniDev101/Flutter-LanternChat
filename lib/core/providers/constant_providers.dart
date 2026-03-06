import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/router/router_provider.dart';
import 'package:lanternchat/models/users/app_user.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// this is just so i don't have to handle a stream convert stream into final AsyncValue<User?> auth
final authStatusProvider = StreamProvider<User?>((ref) {
  final userStream = ref.watch(firebaseAuthProvider).authStateChanges();
  return userStream;
});

final currentUserProvider = Provider<AppUser>((ref) {
  final User? currentUser = ref.watch(firebaseAuthProvider).currentUser;

  if (currentUser == null) {
    throw Exception("User can't be null something went wrong");
    // ref.watch(goRouterProvider).go(AppRoute.login);
  }
  return AppUser.fromFirebaseUser(currentUser);
});
