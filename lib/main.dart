
import 'package:flutter/material.dart';
import 'package:lanternchat/pages/chatpage.dart';
import 'package:lanternchat/pages/homepage.dart';

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
      home: Chatpage(),
      debugShowCheckedModeBanner: false,
    );
  }

}
