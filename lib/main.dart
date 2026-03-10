import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'core/router/router_provider.dart';
import 'core/theme/app_theme.dart';
import 'firebase_options.dart';

// Build a release version
// flutter build apk --release

// Install a Release version
// adb install build/app/outputs/flutter-apk/app-release.apk

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // await UserManager().initializeGoogleSignIn();
  // Initialize Google Sign-In here
  // Get this id from google-services.json (in android/app/), Copy the "client_id" where "client_type": 3
  // ? why : New google_sign_in package (v7+) uses Android Credential Manager. It often can't auto-read the ID from google-services.json, so manual initialization is required.
  await GoogleSignIn.instance.initialize(
    serverClientId: '352733183524-lpcgkaktk59qifrgk1m2glh9h494s26n.apps.googleusercontent.com',
  );
  runApp(ProviderScope(child: const LanternChat()));
}

// Todo implement paging
// Introduce paging
//User scrolls up
//         │
//         ▼
// ScrollController detects threshold
//         │
//         ▼
// loadOlderMessages()
//         │
//         ▼
// Firestore query (startAfterDocument)
//         │
//         ▼
// pagination stream emits messages
//         │
//         ▼
// Rx.merge combines streams
//         │
//         ▼
// StreamBuilder rebuilds UI

class LanternChat extends ConsumerWidget {
  const LanternChat({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(goRouterProvider),
      themeMode: ThemeMode.light,
      darkTheme: Themes.lightThemeData,
      theme: Themes.lightThemeData,
      debugShowCheckedModeBanner: false,
      title: 'Lantern Chat',
    );
  }
}
