import 'package:flutter/material.dart';
import 'package:lanternchat/features/settings/widgets/list_item.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(radius: 40),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      // User name
                      Text("Ashwani Yadav", style: Theme.of(context).textTheme.titleMedium),
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
              SizedBox(height: 10),

              ListItem(icon: Icons.vpn_key_outlined, title: "Account", subtitle: "Security notification, change email"),
              ListItem(
                icon: Icons.lock_outline_rounded,
                title: "Privacy",
                subtitle: "Block contacts, disappearing messages",
              ),
              ListItem(icon: Icons.face, title: "Avatar", subtitle: "Create, edit, profile photo"),
              ListItem(icon: Icons.list_alt, title: "Lists", subtitle: "Manage people and groups"),
              ListItem(icon: Icons.chat_outlined, title: "Chats", subtitle: "Theme, wallpapers, conversation history"),
              ListItem(
                icon: Icons.notifications_none_outlined,
                title: "Notification",
                subtitle: "Message, group & call tones",
              ),
              ListItem(icon: Icons.security_update, title: "App update"),

              SizedBox(height: 20),
              Text("Thanks for using this app", style: Theme.of(context).textTheme.bodySmall),
              Text("Drop a hello in any of my socials", style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
