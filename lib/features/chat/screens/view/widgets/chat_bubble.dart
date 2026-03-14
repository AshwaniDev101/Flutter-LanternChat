import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';

import '../../../../../core/theme/chat_theme.dart';
import '../../../../../models/messages/message_tile.dart';

class ChatBubble extends ConsumerWidget {
  final MessageTile messageTile;

  const ChatBubble({required this.messageTile, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatTheme = Theme.of(context).extension<ChatTheme>()!;
    final currentUser = ref.watch(currentUserProvider);

    final isMine = messageTile.message.senderId == currentUser.uid;

    // final List<String>? seenBy = messageTile.seenMessage?.seenBy;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment:
        isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: isMine
                    ? chatTheme.senderBubble
                    : chatTheme.receivedBubble,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft:
                  isMine ? const Radius.circular(18) : Radius.zero,
                  bottomRight:
                  isMine ? Radius.zero : const Radius.circular(18),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    messageTile.message.text ?? "",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.35,
                      color: isMine ? Colors.black87 : Colors.black87,
                    ),
                  ),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Thinking of idea of separating chat bubbles
class LeftChatBubble extends StatelessWidget {
  final Widget child;

  const LeftChatBubble({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatTheme = Theme.of(context).extension<ChatTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: chatTheme.receivedBubble,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),

              child: child,
              // child: Text(
              //   message,
              //   style: const TextStyle(
              //     fontSize: 15,
              //     height: 1.35,
              //     color: Colors.black87,
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}


class RightChatBubble extends StatelessWidget {
  final String message;

  const RightChatBubble({
    required this.message,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatTheme = Theme.of(context).extension<ChatTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 14,
              ),
              decoration: BoxDecoration(
                color: chatTheme.senderBubble,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.35,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}