import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';
import 'package:lanternchat/models/messages/message.dart';

import '../../../../../core/theme/chat_theme.dart';
import '../../../../../models/users/app_user.dart';

class ChatBubble extends ConsumerWidget {
  final Message message;


  const ChatBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context, ref) {
    final chatTheme = Theme.of(context).extension<ChatTheme>()!;
    final currentUser = ref.watch(currentUserProvider);

    return Row(

      mainAxisAlignment: isMyMessage(currentUser) ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        // if (message.senderId != currentUser.uid)
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.subdirectory_arrow_right_outlined, color: chatTheme.muteColor),
        //   ),

        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: isMyMessage(currentUser) ? Radius.circular(0) :  Radius.circular(20),
              bottomLeft: isMyMessage(currentUser) ? Radius.circular(20) : Radius.circular(0),
            ),
            color: isMyMessage(currentUser) ? chatTheme.senderBubble: chatTheme.receivedBubble,

            border: Border.all(color: Colors.white10),
          ),

          child: Text(message.text.toString(), softWrap: true),
        ),

        // if (message.senderId == currentUser.uid)
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.subdirectory_arrow_right_outlined, color: chatTheme.muteColor),
        //   ),
      ],
    );
  }

  bool isMyMessage(AppUser currentUser)
  {
    return message.senderId == currentUser.uid;
  }
}
