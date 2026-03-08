import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/chat/data/chat_service.dart';
import 'package:lanternchat/features/chat/provider/chat_provider.dart';
import 'package:lanternchat/features/chat/screens/view/widgets/chat_bubble.dart';
import 'package:lanternchat/models/messages/enums/message_type.dart';
import 'package:lanternchat/models/users/app_user.dart';

import '../../../../core/theme/chat_theme.dart';
import '../../../../models/messages/message.dart';
import '../../../../models/users/contact.dart';
import '../../../../shared/widgets/circular_user_avatar.dart';
import '../../../auth/provider/auth_provider.dart';

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

class ChatPage extends ConsumerStatefulWidget {
  final Contact contact;

  const ChatPage({super.key, required this.contact});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController textEditingController = TextEditingController();

  // final ScrollController _scrollController = ScrollController();

  // @override
  // void dispose() {
  //   textEditingController.dispose();
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  //
  // void _scrollToBottom({bool animate = true}) {
  //   if (!_scrollController.hasClients) return;
  //   final position = 0.0; // because reverse: true
  //   if (animate) {
  //     _scrollController.animateTo(position, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  //   } else {
  //     _scrollController.jumpTo(position);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // String conversationId = '';
    final chatStream = ref.watch(chatStreamProvider(widget.contact.conversationId));
    final chatService = ref.watch(chatServiceProvider);
    // final currentUser = ref.watch(firebaseAuthProvider).currentUser!;
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: _appBar(context),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
            child: chatStream.when(
              data: (List<Message> messages) {
                // WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
                return ListView.separated(
                  reverse: true,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: messages.length,
                  padding: EdgeInsets.all(16),

                  itemBuilder: (context, index) {
                    //// When reverse: true, index 0 = newest message
                    final message = messages[messages.length - 1 - index];
                    return ChatBubble(message: message);
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
          CircularUserAvatar(imageUrl: widget.contact.photoURL, radius: 20),
          SizedBox(width: 8),
          Text(
            widget.contact.name,
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

  Widget _textArea(BuildContext context, ChatService chatService, AppUser currentUser) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final hasText = textEditingController.text.trim().isNotEmpty;

    final showSend = keyboardOpen && hasText;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textEditingController,
              onChanged: (_) => setState(() {}),
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

          showSend
              ? IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final text = textEditingController.text.trim();

                    if (text.isEmpty) return;

                    final message = Message(
                      messageId: '',
                      senderId: currentUser.uid,
                      messageType: MessageType.text,
                      createdAt: Timestamp.now(),
                      text: text,
                    );

                    chatService.addChatString(widget.contact.conversationId, message);

                    textEditingController.clear();
                  },
                )
              : IconButton(icon: Icon(Icons.mic), onPressed: () {}),
        ],
      ),
    );
  }
}
