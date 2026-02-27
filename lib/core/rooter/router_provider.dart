import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/features/conversation/conversation_page.dart';
import 'package:lanternchat/features/home/chat/select_contact/select_contact_page.dart';

import '../../features/home/home_page.dart';
import '../../features/login/login_page.dart';
import '../../features/profile/profile_page.dart';
import '../../features/settings/qr_code/qr_page.dart';
import '../../features/settings/settings_page.dart';
import '../providers/constant_providers.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  /// notifyListeners() is provided by ChangeNotifier.
  /// When the stream emits a new value, stream.listen() captures it
  /// and triggers notifyListeners() to refresh GoRouter.
  /// The StreamSubscription is stored so it can be properly cancelled in dispose().

  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

class AppRoute {
  static const home = '/';
  static const login = '/login';
  static const profile = '/profile';
  static const settings = '/settings';
  static const selectContact = '/select-contact';
  static const conversation = '/chat-window';
  static const qrCode = '/qr_code-code';
}

final goRouterProvider = Provider((ref) {
  final auth = ref.watch(firebaseAuthProvider);

  return GoRouter(
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),
    initialLocation: AppRoute.login,
    // redirect run on every route change.
    redirect: (BuildContext context, GoRouterState state) {
      final user = auth.currentUser;
      final isOnLoginPage = state.matchedLocation == AppRoute.login;

      if (user == null && !isOnLoginPage) {
        return AppRoute.login;
      }
      if (user != null && isOnLoginPage) {
        // return AppRoute.home;
        return AppRoute.qrCode;
      }

      return null;
    },
    routes: <RouteBase>[
      GoRoute(
        path: AppRoute.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),

      GoRoute(
        path: AppRoute.profile,
        builder: (BuildContext context, GoRouterState state) {
          return const ProfilePage();
        },
      ),

      GoRoute(
        path: AppRoute.settings,
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsPage();
        },
      ),

      GoRoute(
        path: AppRoute.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginPage();
        },
      ),

      GoRoute(
        path: AppRoute.selectContact,
        builder: (BuildContext context, GoRouterState state) {
          return const SelectContactPage();
        },
      ),

      GoRoute(
        path: AppRoute.conversation,
        builder: (BuildContext context, GoRouterState state) {
          final otherUser = state.extra as User;
          return ConversationPage(otherUser: otherUser);
        },
      ),

      GoRoute(
        path: AppRoute.qrCode,
        builder: (BuildContext context, GoRouterState state) {
          return QrCodePage();
        },
      ),
    ],
  );
});
