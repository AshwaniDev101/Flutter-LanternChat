
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [

          CircleAvatar(radius: 50,),
          Text("Arun"),

          Row(
            children: [
              _rowButton(icon:Icons.message_outlined,title:'Message'),
              _rowButton(icon:Icons.call_outlined,title:'Audio'),
              _rowButton(icon:Icons.videocam_outlined,title:'Video'),
              _rowButton(icon:Icons.note_alt_outlined,title:'Note'),
            ],
          )


        ],
      ),
    );
  }

  Widget _rowButton({required IconData icon, required String title}) {

    return Container(
      decoration: BoxDecoration(),
    child: Column(
      children: [
        Icon(icon),
        Text(title),
      ],
    ),
    );
  }
}
