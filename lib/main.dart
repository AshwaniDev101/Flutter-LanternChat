import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/pages/loginpage/loginpage.dart';
import 'package:lanternchat/pages/profilepage/profilepage.dart';
import 'package:lanternchat/pages/settingspage/settingspage.dart';
import 'package:lanternchat/style/themes.dart';

import 'core/user_manager.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Google Sign-In here
  await UserManager().initializeGoogleSignIn();
  runApp(ProviderScope(child: const LanternChat()));
}

class LanternChat extends StatelessWidget {
  const LanternChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      darkTheme: Themes.lightThemeData,
      theme: Themes.lightThemeData,

      // home: Chatpage(),
      // home: Homepage(),
      home: LoginPage(),
      // home: ProfilePage(),
      // home: SettingsPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
