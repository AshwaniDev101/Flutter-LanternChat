import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/auth/provider/auth_provider.dart';

import '../../../../../core/theme/chat_theme.dart';
import '../../../../../models/conversations/conversation_tile.dart';
import '../../../../../models/messages/message_tile.dart';

class ChatBubble extends ConsumerWidget {
  final MessageTile messageTile;
  final ConversationTile conversationTile;

  const ChatBubble({required this.messageTile,required this.conversationTile ,super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatTheme = Theme.of(context).extension<ChatTheme>()!;
    final currentUser = ref.watch(currentUserProvider);

    final isMine = messageTile.message.senderId == currentUser.uid;

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

                child :Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      messageTile.message.text ?? "",
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.35,
                        color: isMine?Colors.black:Colors.black,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(messageTile.message.createdAt),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.blueGrey.shade800,
                            fontSize: 11,
                          ),
                        ),

                        if (isMine) ...[
                          const SizedBox(width: 4),

                          // isSeenByOtherUser?Icon(
                          //   Icons.done_all,
                          //   size: 16,
                          //   color: Colors.white,
                          // ):
                          // Text('seen',style: Theme.of(context).textTheme.bodySmall,),
                          Icon(
                            Icons.done_all,
                            size: 16,
                            color:  Colors.blueGrey.shade900,
                          ),
                        ]
                      ],
                    )
                  ],
                )
              // child: Column(
              //   children: [
              //     Text(
              //       messageTile.message.text ?? "",
              //       style: TextStyle(
              //         fontSize: 15,
              //         height: 1.35,
              //         color: isMine ? Colors.black87 : Colors.black87,
              //       ),
              //     ),
              //     if (isMine && isSeenByOtherUser) Text("seen", style: Theme.of(context).textTheme.bodySmall),
              //   ],
              // ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(Timestamp timestamp) {
    final date = timestamp.toDate();
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');

    return "$hour:$minute";
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