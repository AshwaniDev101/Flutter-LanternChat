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
  Widget build(BuildContext context, WidgetRef ref) {
    final chatTheme = Theme.of(context).extension<ChatTheme>()!;
    final currentUser = ref.watch(currentUserProvider);

    final isMine = message.senderId == currentUser.uid;

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
              child: Text(
                message.text ?? "",
                style: TextStyle(
                  fontSize: 15,
                  height: 1.35,
                  color: isMine ? Colors.black87 : Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}