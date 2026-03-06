import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/providers/constant_providers.dart';
import 'package:lanternchat/features/chat/data/chat_service.dart';
import 'package:lanternchat/features/chat/provider/provider.dart';
import 'package:lanternchat/models/messages/enums/message_type.dart';

import '../../../../core/theme/chat_theme.dart';
import '../../../../models/messages/message.dart';
import '../../../../models/users/contact.dart';
import '../../../../shared/widgets/circular_user_avatar.dart';

// Popup Option menu for the Chat page
enum ChatPagePopupMenu {
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
extension on ChatPagePopupMenu {
  String get action {
    return switch (this) {
      ChatPagePopupMenu.newGroup => "New Group",
      ChatPagePopupMenu.viewContact => "View Contact",
      ChatPagePopupMenu.search => "Search",
      ChatPagePopupMenu.mediaLinksDocs => "Media, Links, and Docs",
      ChatPagePopupMenu.muteNotifications => "Mute Notifications",
      ChatPagePopupMenu.disappearingMessages => "Disappearing Messages",
      ChatPagePopupMenu.chatTheme => "Chat Theme",
      ChatPagePopupMenu.more => "More",
    };
  }
}

class ChatPage extends ConsumerWidget {
  final Contact contact;
  final TextEditingController textEditingController = TextEditingController();

  ChatPage({super.key, required this.contact});

  @override
  Widget build(BuildContext context, ref) {
    String conversationId = '';
    final chatStream = ref.watch(chatStreamProvider(conversationId));
    final chatService = ref.watch(chatServiceProvider);
    final currentUser = ref.watch(firebaseAuthProvider).currentUser!;

    final chatTheme = Theme.of(context).extension<ChatTheme>()!;
    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
            child: chatStream.when(
              data: (List<Message> messages) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: 20,
                  padding: EdgeInsets.all(16),

                  itemBuilder: (context, index) {
                    final bool isSelf = index % 2 == 0;

                    return chatBubble(context, chatTheme, isSelf);
                  },
                );
              },
              error: (e, t) {
                print("Error $e, $t");
                return Center(child: Text("Error $e"));
              },
              loading: () {
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),

          _textArea(context, chatService, currentUser),
        ],
      ),
    );
  }

  // Page App bar
  AppBar _appBar(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          CircularUserAvatar(imageUrl: contact.photoURL, radius: 20),
          SizedBox(width: 8),
          Text(
            contact.name,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),

      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.videocam_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.call_outlined)),
        PopupMenuButton(
          itemBuilder: (context) {
            return ChatPagePopupMenu.values.map((value) {
              return PopupMenuItem(value: value, child: Text(value.action));
            }).toList();
          },
        ),
      ],
    );
  }

  // This is the main chat window with all the chat messages
  // Widget _messageList(BuildContext context) {
  //   final chatTheme = Theme.of(context).extension<ChatTheme>()!;
  //
  //   return Expanded(
  //     child: ListView.separated(
  //       separatorBuilder: (context, index) {
  //         return SizedBox(height: 10);
  //       },
  //       itemCount: 20,
  //       padding: EdgeInsets.all(16),
  //
  //       itemBuilder: (context, index) {
  //         final bool isSelf = index % 2 == 0;
  //
  //         return chatBubble(context, chatTheme, isSelf);
  //       },
  //     ),
  //   );
  // }

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

  Widget _textArea(BuildContext context, ChatService chatService, User currentUser) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
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

          textEditingController.value.toString().isEmpty
              ? IconButton(onPressed: () {}, icon: Icon(Icons.mic))
              : IconButton(
                  onPressed: () {
                    final text = textEditingController.value.toString();

                    final message = Message(
                      messageId: '',
                      senderId: currentUser.uid.toString(),
                      messageType: MessageType.text,
                      createdAt: Timestamp.now(),
                      text: text,
                    );
                    chatService.addChatString(contact.conversationId, message);
                  },
                  icon: Icon(Icons.send),
                ),
        ],
      ),
    );
  }
}
