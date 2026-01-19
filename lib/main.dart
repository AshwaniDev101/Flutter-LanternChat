
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lanternchat/pages/chatpage.dart';
import 'package:lanternchat/pages/homepage.dart';
import 'package:lanternchat/style/themes.dart';

import 'firebase_options.dart';

void main() async
{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const LanternChat());
}

class LanternChat extends StatelessWidget{
  const LanternChat({super.key});



  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      // home: Homepage(),
      themeMode: ThemeMode.light,
      darkTheme: Themes.lightThemeData,
      theme: Themes.lightThemeData,

      home: Chatpage(),
      debugShowCheckedModeBanner: false,
    );
  }

}
