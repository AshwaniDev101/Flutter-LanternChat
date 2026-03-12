import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/models/users/contact.dart';

import '../../../../../models/conversations/conversation_tile.dart';


class TypingIndicator extends ConsumerWidget {
  final ConversationTile conversationTile;

  const TypingIndicator({required this.conversationTile, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final participantStream = ref.watch(participantStreamProvider(contact.conversationId));


    return Icon(Icons.more_horiz_rounded);
    // return participantStream.when(
    //   data: (List<Participant> pList) {
    //
    //     for(Participant p in pList)
    //       {
    //         if(p.participantID==contact.uid)
    //           {
    //             return Container(height: 40, width: 80, color: Colors.blue, child: Text(TimerFormateHelper.formatTimestampTime(p.typingAt)),);
    //           }else
    //             {
    //               return Container(height: 0, width: 0, color: Colors.black);
    //             }
    //       }
    //     return Container(height: 40, width: 80, color: Colors.red);
    //   },
    //   error: (e, t) {
    //     return Text('Error: $e');
    //   },
    //   loading: () {
    //     return CircularProgressIndicator();
    //   },
    // );
  }
}
