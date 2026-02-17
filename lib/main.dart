import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lanternchat/pages/root/router_provider.dart';
import 'package:lanternchat/style/themes.dart';
import 'firebase_options.dart';

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
