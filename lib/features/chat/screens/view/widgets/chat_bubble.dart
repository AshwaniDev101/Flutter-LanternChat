import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/theme/app_colors.dart';
import 'package:lanternchat/models/conversations/enums/conversation_type.dart';
import 'package:lanternchat/models/messages/message.dart';
import 'package:lanternchat/shared/widgets/circular_user_avatar.dart';

import '../../../../../core/theme/chat_theme.dart';
import '../../../../../models/users/contact.dart';
import '../../../../auth/provider/auth_provider.dart';
import '../../../../contact/provider/contact_providers.dart';

class ChatBubble extends ConsumerWidget {
  final Message message;
  final ConversationType conversationType;

  const ChatBubble({ required this.conversationType, required this.message,   super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatTheme = Theme.of(context).extension<ChatTheme>()!;

    final currentUser = ref.read(currentUserProvider);
    final Map<String, Contact> contactMap = ref.watch(contactsMapProvider);

    final isMine = message.senderId == currentUser.uid;

    return Row(
      mainAxisAlignment: isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (contactMap[message.senderId] != null && conversationType == ConversationType.group)
              CircularUserAvatar(imageUrl: contactMap[message.senderId]!.photoURL, radius: 20),
            SizedBox(width: 8),

            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                decoration: BoxDecoration(
                  color: isMine ? chatTheme.senderBubble : chatTheme.receivedBubble,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(18),
                    topRight: const Radius.circular(18),
                    bottomLeft: isMine ? const Radius.circular(18) : Radius.zero,
                    bottomRight: isMine ? Radius.zero : const Radius.circular(18),
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (contactMap[message.senderId] != null)
                      Text(
                        contactMap[message.senderId]!.name,
                        style: TextStyle(color: isMine ? chatTheme.senderBubbleTitle: chatTheme.receivedBubbleTitle, fontWeight: FontWeight.w500, fontSize: 14),
                      ),

                    message.isDeleted? Text(
                      "deleted",
                      style: TextStyle(fontSize: 15, height: 1.35, color: isMine ? chatTheme.senderBubbleDeleted : chatTheme.receivedBubbleDeleted, fontStyle: FontStyle.italic),
                    ):
                    Text(
                      message.text ?? "",
                      style: TextStyle(fontSize: 15, height: 1.35, color: isMine ? chatTheme.senderBubbleText : chatTheme.receivedBubbleText),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _formatTime(message.createdAt),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: isMine ? chatTheme.senderBubbleMuteColor: chatTheme.receivedBubbleMuteColor, fontSize: 11),
                        ),

                        if (isMine) ...[
                          const SizedBox(width: 4),
                          Icon(Icons.done_all, size: 16, color: Colors.blueGrey.shade900),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
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

  const LeftChatBubble({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    final chatTheme = Theme.of(context).extension<ChatTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: chatTheme.receivedBubble,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),

              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

class RightChatBubble extends StatelessWidget {
  final String message;

  const RightChatBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final chatTheme = Theme.of(context).extension<ChatTheme>()!;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              decoration: BoxDecoration(
                color: chatTheme.senderBubble,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                ),
              ),
              child: Text(message, style: const TextStyle(fontSize: 15, height: 1.35, color: Colors.black87)),
            ),
          ),
        ],
      ),
    );
  }
}
