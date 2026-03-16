import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextArea extends ConsumerStatefulWidget {
  // final ConversationTile conversationTile;
  final Function(String) onSend;
  final Function(String) onTyping;

  const TextArea({required this.onSend, required this.onTyping, super.key});

  @override
  ConsumerState<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends ConsumerState<TextArea> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    // final hasText = textEditingController.text.trim().isNotEmpty;
    // final showSend = keyboardOpen && hasText;

    // Todo think about adding a typo function in which whatever one side type is visible to other side insistently , it to learn the emotion of someone who is typing
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.emoji_emotions_outlined)),
                  Expanded(
                    child: TextField(
                      controller: textEditingController,
                      onChanged: widget.onTyping,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(hintText: "Type a message", border: InputBorder.none),
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.attachment)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt_outlined)),
                ],
              ),
            ),
          ),

          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              final text = textEditingController.text.trim();

              if (text.isEmpty) return;

              // chatService.sendMessageTo(conversation: widget.conversationTile.conversation, message: message);

              widget.onSend(text);
              // _sendMessage(message);
              textEditingController.clear();
            },
          ),
          // showSend
          //     ? IconButton(
          //         icon: Icon(Icons.send),
          //         onPressed: () {
          //           final text = textEditingController.text.trim();
          //
          //           if (text.isEmpty) return;
          //
          //           final message = Message(
          //             messageId: '',
          //             senderId: currentUser.uid,
          //             messageType: MessageType.text,
          //             createdAt: Timestamp.now(),
          //             text: text,
          //           );
          //
          //           chatService.sendMessageTo(conversation: widget.conversationTile.conversation, message: message);
          //
          //           textEditingController.clear();
          //         },
          //       )
          //     : IconButton(icon: Icon(Icons.mic), onPressed: () {}),
        ],
      ),
    );
  }
}
