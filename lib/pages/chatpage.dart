import 'package:flutter/material.dart';

// Popup Option menu for the Chat page
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

// extension allows additional functionality to enums
extension on ChatpagePopupMenu {
  String get action {
    return switch (this) {
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
      appBar: _appBar(context),
      body: Column(children: [_messageList(context), _textArea(context)]),
    );
  }

  // Page App bar
  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Text("User Name "),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.videocam_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.call_outlined)),
        PopupMenuButton(
          itemBuilder: (context) {
            return ChatpagePopupMenu.values.map((value) {
              return PopupMenuItem(value: value, child: Text(value.action));
            }).toList();
          },
        ),
      ],
    );
  }

  // This is the main chat window with all the chat messages
  Widget _messageList(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemCount: 20,
        padding: EdgeInsets.all(16),

        itemBuilder: (context, index) {
          final bool isSelf = index % 2 == 0;

          if (isSelf) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.blueGrey[200],

                    border: Border.all(color: Colors.white10),
                  ),

                  child: Text('hi  how are you, this is just a testing message', softWrap: true),
                ),

                IconButton(onPressed: () {}, icon: Icon(Icons.subdirectory_arrow_right_outlined)),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.subdirectory_arrow_right_outlined)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.green[200],

                    border: Border.all(color: Colors.white10),
                  ),

                  child: Text('Yea im fine, i know this is just a testing message', softWrap: true),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  // Area where user type there messages
  Widget _textArea(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.emoji_emotions_outlined)),

                suffixIcon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.attachment)),
                    IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
                  ],
                ),

                border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
            ),
          ),

          IconButton(onPressed: () {}, icon: Icon(Icons.mic)),
        ],
      ),
    );
  }
}
