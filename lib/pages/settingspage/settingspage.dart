import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(radius: 40),
            Column(
              children: [
                // User name
                Text("Ashwani Yadav"),
                ElevatedButton(onPressed: () {}, child: Text('status')),
              ],
            ),

            IconButton(onPressed: () {}, icon: Icon(Icons.qr_code)),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_circle_outline_rounded, color: Colors.green),
            ),
          ],
        ),

        _listItem(icon: Icons.vpn_key_outlined, title: "Account", subtitle: "Security notification, change email"),
        _listItem(
          icon: Icons.lock_outline_rounded,
          title: "Privacy",
          subtitle: "Block contacts, disappearing messages",
        ),
        _listItem(icon: Icons.vpn_key_outlined, title: "Avatar", subtitle: "Create, edit, profile photo"),
        _listItem(icon: Icons.vpn_key_outlined, title: "Lists", subtitle: "Manage people and groups"),
        _listItem(icon: Icons.vpn_key_outlined, title: "Chats", subtitle: "Theme, wallpapers, chat history"),
        _listItem(icon: Icons.vpn_key_outlined, title: "Notification", subtitle: "Message, group & call tones"),
        _listItem(icon: Icons.vpn_key_outlined, title: "App update"),

        Text("Thanks for using this app"),
        Text("Drop a hello in any of my socials"),


      ],
    );
  }

  Widget _listItem({required IconData icon, required String title, String? subtitle}) {
    return Row(
      children: [
        Icon(icon),
        Column(
          children: [
            Text(title),
            if (subtitle != null) Text(subtitle, style: TextStyle(color: Colors.grey)),
          ],
        ),
      ],
    );
  }
}
