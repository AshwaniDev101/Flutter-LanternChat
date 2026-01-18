
import 'package:flutter/material.dart';
import 'package:lanternchat/pages/chatpage.dart';
import 'package:lanternchat/pages/homepage.dart';
import 'package:lanternchat/style/themes.dart';

void main()
{
  runApp(const LanternChat());
}

class LanternChat extends StatelessWidget{
  const LanternChat({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      // home: Homepage(),
      theme: Themes.lightThemeData,
      themeMode: ThemeMode.light,
      darkTheme: Themes.lightThemeData,
      home: Chatpage(),
      debugShowCheckedModeBanner: false,
    );
  }

}
