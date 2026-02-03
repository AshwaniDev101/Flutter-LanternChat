import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("Settings"),),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              SizedBox(height: 20,),
              Row(
                children: [
                  CircleAvatar(radius: 40),
                  SizedBox(width: 10,),
                  Column(
                    children: [
                      // User name
                      Text("Ashwani Yadav", style: TextStyle(fontSize: 18),),
                      ElevatedButton(onPressed: () {}, child: Text('status')),
                    ],
                  ),
                  Spacer(),

                  IconButton(onPressed: () {}, icon: Icon(Icons.qr_code)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add_circle_outline_rounded, color: Colors.green),
                  ),
                ],
              ),
              SizedBox(height: 10,),

              _listItem(icon: Icons.vpn_key_outlined, title: "Account", subtitle: "Security notification, change email"),
              _listItem(
                icon: Icons.lock_outline_rounded,
                title: "Privacy",
                subtitle: "Block contacts, disappearing messages",
              ),
              _listItem(icon: Icons.face, title: "Avatar", subtitle: "Create, edit, profile photo"),
              _listItem(icon: Icons.list_alt, title: "Lists", subtitle: "Manage people and groups"),
              _listItem(icon: Icons.chat_outlined, title: "Chats", subtitle: "Theme, wallpapers, chat history"),
              _listItem(icon: Icons.notifications_none_outlined, title: "Notification", subtitle: "Message, group & call tones"),
              _listItem(icon: Icons.security_update, title: "App update"),

              SizedBox(height: 20,),
              Text("Thanks for using this app",style: TextStyle(color: Colors.grey),),
              Text("Drop a hello in any of my socials",style: TextStyle(color: Colors.grey),),


            ],
          ),
        ),
      ),
    );
  }

  Widget _listItem({required IconData icon, required String title, String? subtitle}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[700],),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style: TextStyle(color: Colors.grey[700],fontWeight: FontWeight.bold),),
              if (subtitle != null) Text(subtitle, style: TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}
