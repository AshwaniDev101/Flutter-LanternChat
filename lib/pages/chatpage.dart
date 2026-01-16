import 'package:flutter/material.dart';

enum ChatpagePopupMenu {
  newGroup,
  viewContact,
  search,
  mediaLinksDocs,
  muteNotifications,
  disappearingMessages,
  chatTheme,
  more,
}

extension on ChatpagePopupMenu
{
  String get action{
    return switch(this)
    {
      ChatpagePopupMenu.newGroup => "New Group",
      ChatpagePopupMenu.viewContact => "View Contact",
      ChatpagePopupMenu.search => "Search",
      ChatpagePopupMenu.mediaLinksDocs => "Media, Links, and Docs",
      ChatpagePopupMenu.muteNotifications => "Mute Notifications",
      ChatpagePopupMenu.disappearingMessages => "Disappearing Messages",
      ChatpagePopupMenu.chatTheme => "Chat Theme",
      ChatpagePopupMenu.more => "More",
    };
  }
}

class Chatpage extends StatelessWidget {
  const Chatpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Name "),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.call_outlined)),
          PopupMenuButton(
            itemBuilder: (context) {
              return ChatpagePopupMenu.values.map((value){
                return PopupMenuItem(value:value, child: Text(value.action));
              }).toList();
            },
          ),
        ],
      ),
      body: Column(children: []),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.emoji_emotions_outlined)),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),
            ),

            IconButton(onPressed: () {}, icon: Icon(Icons.attachment)),
            IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),

            IconButton(onPressed: () {}, icon: Icon(Icons.mic)),
          ],
        ),
      ),
    );
  }
}
