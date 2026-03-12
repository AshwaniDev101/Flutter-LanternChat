import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/chat/provider/typing_provider.dart';
import 'package:lanternchat/models/users/contact.dart';

import '../../../../../models/conversations/conversation_tile.dart';

class TypingIndicator extends ConsumerWidget {
  final String conversationId;
  final String uid;

  const TypingIndicator({required this.conversationId, required this.uid, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final participantStream = ref.watch(participantStreamProvider(contact.conversationId));

    final typingStream = ref.watch(typingStreamProvider(TypingTo(conversationId: conversationId, uid: uid)));

    return typingStream.when(
      data: (DatabaseEvent data) {

        final text = data.snapshot.value.toString();

        return Text('$text ');
        // return Icon(Icons.more_horiz_rounded);
      },
      error: (err, stack) => Text('There is an Error: $err'),
      loading: () => LinearProgressIndicator(),
    );
  }
}
