import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/core/providers/auth_provider.dart';
import 'package:lanternchat/pages/login/username_setup_page.dart';
import 'package:lanternchat/pages/settings/settings_page.dart';

import '../home/home_page.dart';
import '../login/login_page.dart';
import '../profile/profilepage.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final goRouterProvider = Provider((ref) {
  final auth = ref.watch(firebaseAuthProvider);

  return GoRouter(
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),
    initialLocation: '/login',
    // redirect run on every route change.
    redirect: (BuildContext context, GoRouterState state) {
      final user = ref.watch(firebaseAuthProvider).currentUser;
      final isOnLoginPage = state.matchedLocation == '/login';

      if (user == null && !isOnLoginPage) {
        return '/login';
      }
      if (user != null && isOnLoginPage) {
        return '/username_setup';
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),

      GoRoute(
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) {
          return const ProfilePage();
        },
      ),

      GoRoute(
        path: '/settings',
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsPage();
        },
      ),

      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),

      GoRoute(
        path: '/username_setup',
        builder: (BuildContext context, GoRouterState state) {
          return UsernameSetupPage();
        },
      ),
    ],
  );
});
