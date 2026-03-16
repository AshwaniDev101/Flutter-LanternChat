import 'package:lanternchat/models/messages/message.dart';
import 'package:lanternchat/models/messages/seen_message.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../models/messages/message_tile.dart';

class ChatStreamUtils {
  static Stream<List<MessageTile>> messageTileStream(
    Stream<List<Message>> messageStream,
    Stream<List<SeenMessage>?> seenMessageStream,
  ) {
    return Rx.combineLatest2(messageStream, seenMessageStream, (
      List<Message> messages,
      List<SeenMessage>? seenMessages,
    ) {
      // Build fast lookup map
      final seenMap = {for (final seen in (seenMessages ?? [])) seen.lastSeenMessageId: seen};

      return messages.map((message) {
        return MessageTile(message: message, seenMessage: seenMap[message.messageId]);
      }).toList();
    });
  }

  // This is O(n2). For chats with many messages its better to build a map.
  // return Rx.combineLatest2(
  //   messageStream,
  //   seenMessageStream,
  //       (
  //       List<Message> messages,
  //       List<SeenMessage>? seenMessages,
  //       ) {
  //     return messages.map((message) {
  //       final seenMessage = seenMessages?.firstWhere(
  //             (seen) => seen.seenMessageId == message.messageId,
  //         orElse: () => null,
  //       );
  //
  //       return MessageTile(
  //         message: message,
  //         seenMessage: seenMessage,
  //       );
  //     }).toList();
  //   },
  // );
}
