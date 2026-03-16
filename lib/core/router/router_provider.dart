import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lanternchat/models/conversations/conversation_tile.dart';
import 'package:lanternchat/models/conversations/group_info.dart';

import '../../features/auth/provider/auth_provider.dart';
import '../../features/chat/group_chat/screens/view/group_chat_page.dart';
import '../../features/chat/group_chat/screens/view/group_setup_page.dart';
import '../../features/chat/solo_chat/screens/view/chat_page.dart';
import '../../features/contact/screens/view/contact_page.dart';
import '../../features/home/screens/view/home_page.dart';
import '../../features/auth/screens/view/auth_page.dart';
import '../../features/profile/screens/view/profile_page.dart';
import '../../features/qr/screens/view/qr_page.dart';
import '../../features/settings/screens/view/settings_page.dart';

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
  static const auth = '/login';
  static const profile = '/profile';
  static const settings = '/settings';
  static const selectContact = '/select-contact';
  static const chat = '/conversation-window';
  static const qrCode = '/qr-code';
  static const groupSetup = '/group-setup';
  static const groupChat = '/group-chat';
}

final goRouterProvider = Provider((ref) {
  final FirebaseAuth auth = ref.watch(firebaseAuthProvider);
  // final AsyncValue<User?> auth = ref.watch(authStatusProvider);

  return GoRouter(
    refreshListenable: GoRouterRefreshStream(auth.authStateChanges()),
    initialLocation: AppRoute.auth,
    // redirect run on every route change.
    redirect: (BuildContext context, GoRouterState state) {

      final User? user = auth.currentUser;
      final isOnLoginPage = state.matchedLocation == AppRoute.auth;

      if (user == null && !isOnLoginPage) {

        return AppRoute.auth;
      }
      if (user != null && isOnLoginPage) {
        return AppRoute.home;
        // return AppRoute.qrCode;
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
        path: AppRoute.auth,
        builder: (BuildContext context, GoRouterState state) {
          return const AuthPage();
        },
      ),

      GoRoute(
        path: AppRoute.selectContact,
        builder: (BuildContext context, GoRouterState state) {
          return const ContactPage();
        },
      ),

      GoRoute(
        path: AppRoute.chat,
        builder: (BuildContext context, GoRouterState state) {
          final conversationTile = state.extra as ConversationTile;
          return ChatPage(conversationTile: conversationTile);
        },
      ),

      GoRoute(
        path: AppRoute.qrCode,
        builder: (BuildContext context, GoRouterState state) {
          return QrCodePage();
        },
      ),

      GoRoute(
        path: AppRoute.groupSetup,
        builder: (BuildContext context, GoRouterState state) {
          return GroupSetupPage();
        },
      ),

      GoRoute(
        path: AppRoute.groupChat,
        builder: (BuildContext context, GoRouterState state) {
          final groupInfo = state.extra as GroupInfo;
          return GroupChatPage(groupInfo: groupInfo);
        },
      ),
    ],
  );
});
