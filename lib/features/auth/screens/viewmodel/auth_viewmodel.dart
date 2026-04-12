import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/firebase/provider/firebase_providers.dart';
import '../../../../models/users/app_user.dart';
import '../../provider/auth_provider.dart';


class AuthViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> googleSignIn() async {
    state = const AsyncLoading();

    // AsyncValue.guard gives you inbuild try-catch like functionality
    state = await AsyncValue.guard(() async {
      final user = await ref.read(authManagerProvider).signInWithGoogle();

      if (user != null) {
        final appUser = AppUser.fromFirebaseUser(user);
        await ref.read(firestoreServiceProvider)
            .addAsNewUser(appUser: appUser);
      }
    });
  }
}

final authViewModelProvider = AsyncNotifierProvider<AuthViewModel, void>(() => AuthViewModel());
