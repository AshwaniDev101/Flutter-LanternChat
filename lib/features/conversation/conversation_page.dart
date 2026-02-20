import 'package:flutter/material.dart';

import '../../core/theme/chat_theme.dart';

// Popup Option menu for the Chat page
enum ConversationPagePopupMenu {
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
extension on ConversationPagePopupMenu {
  String get action {
    return switch (this) {
      ConversationPagePopupMenu.newGroup => "New Group",
      ConversationPagePopupMenu.viewContact => "View Contact",
      ConversationPagePopupMenu.search => "Search",
      ConversationPagePopupMenu.mediaLinksDocs => "Media, Links, and Docs",
      ConversationPagePopupMenu.muteNotifications => "Mute Notifications",
      ConversationPagePopupMenu.disappearingMessages => "Disappearing Messages",
      ConversationPagePopupMenu.chatTheme => "Chat Theme",
      ConversationPagePopupMenu.more => "More",
    };
  }
}

class ConversationPage extends StatelessWidget {
  const ConversationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: Colors.grey[200],
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
            return ConversationPagePopupMenu.values.map((value) {
              return PopupMenuItem(value: value, child: Text(value.action));
            }).toList();
          },
        ),
      ],
    );
  }

  // This is the main conversation window with all the conversation messages
  Widget _messageList(BuildContext context) {
    final chatTheme = Theme.of(context).extension<ChatTheme>()!;

    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemCount: 20,
        padding: EdgeInsets.all(16),

        itemBuilder: (context, index) {
          final bool isSelf = index % 2 == 0;

          return chatBubble(context, chatTheme, isSelf);
        },
      ),
    );
  }

  Widget chatBubble(BuildContext context, ChatTheme chatTheme, bool isSelf) {
    return Row(
      mainAxisAlignment: isSelf ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (!isSelf)
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.subdirectory_arrow_right_outlined, color: chatTheme.muteColor),
          ),

        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: isSelf ? Radius.circular(20) : Radius.circular(0),
              bottomLeft: isSelf ? Radius.circular(0) : Radius.circular(20),
            ),
            color: isSelf ? chatTheme.receivedBubble : chatTheme.senderBubble,

            border: Border.all(color: Colors.white10),
          ),

          child: Text(
            isSelf
                ? 'Yea im fine, i know this is just a testing message'
                : 'hi  how are you, this is just a testing message',
            softWrap: true,
          ),
        ),

        if (isSelf)
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.subdirectory_arrow_right_outlined, color: chatTheme.muteColor),
          ),
      ],
    );
  }

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
