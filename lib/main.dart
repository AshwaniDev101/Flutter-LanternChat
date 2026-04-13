import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lanternchat/core/services/shared_preference/provider/shared_preference_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_lifecycle_handler.dart';
import 'core/router/router_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/providers/theme_mode_provider.dart';
import 'firebase_options.dart';

// Build a release version
// flutter build apk --release

// Install a Release version
// adb install build/app/outputs/flutter-apk/app-release.apk

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // NOTE:
  // - The 'serverClientId' MUST be provided manually.
  // - Find it in: android/app/google-services.json
  //   Look for the entry where "client_type": 3
  //
  // WHY?:
  // - google_sign_in (v7+) uses Android Credential Manager
  // - It may NOT automatically read the client ID from google-services.json
  // - Without manual initialization, sign-in can fail silently or behave inconsistently

  await GoogleSignIn.instance.initialize(
    serverClientId: '352733183524-lpcgkaktk59qifrgk1m2glh9h494s26n.apps.googleusercontent.com',
  );

  // Initializing the SharedPreferences
  final prefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
      child: AppLifecycleHandler(child: const LanternChat()),
    ),
  );
}

// Todo [Future feature] implement paging
// Introduce paging
// User scrolls up
// ScrollController detects threshold
// loadOlderMessages()
// Firestore query (startAfterDocument)
// pagination stream emits messages
// Rx.merge combines streams
// StreamBuilder rebuilds UI

class LanternChat extends ConsumerWidget {
  const LanternChat({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      routerConfig: ref.watch(goRouterProvider),
      themeMode: themeMode,
      theme: Themes.lightThemeData,
      darkTheme: Themes.darkThemeData,

      debugShowCheckedModeBanner: false,
      title: 'Lantern Chat',

      builder: (context, child) {
        return AnimatedTheme(
          data: themeMode == ThemeMode.dark ? Themes.darkThemeData : Themes.lightThemeData,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          child: child!,
        );
      },
    );
  }
}
