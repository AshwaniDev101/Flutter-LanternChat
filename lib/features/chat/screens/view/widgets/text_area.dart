import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../models/messages/enums/message_type.dart';
import '../../../../../models/messages/message.dart';
import '../../../../../models/users/app_user.dart';
import '../../../../../models/users/contact.dart';
import '../../../../auth/provider/auth_provider.dart';
import '../../../data/chat_service.dart';

import '../../../provider/chat_provider.dart';

class TextArea extends ConsumerStatefulWidget {
  final Contact contact;

  const TextArea({required this.contact, super.key});

  @override
  ConsumerState<TextArea> createState() => _TextAreaState();
}

class _TextAreaState extends ConsumerState<TextArea> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    final hasText = textEditingController.text.trim().isNotEmpty;

    final showSend = keyboardOpen && hasText;

    final AppUser currentUser = ref.watch(currentUserProvider);

    final ChatService chatService = ref.read(chatServiceProvider);

    // final ParticipantService participantService = ref.read(participantServiceProvider);

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
                      onChanged: (text) {
                        setState(() {});


                        print('### $text');
                        // participantService.typing(widget.contact.conversationId, currentUser.uid);
                      },
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

                    chatService.sendMessageTo(contact: widget.contact, message: message);

                    textEditingController.clear();
                  },
                )
              : IconButton(icon: Icon(Icons.mic), onPressed: () {}),
        ],
      ),
    );
  }
}
