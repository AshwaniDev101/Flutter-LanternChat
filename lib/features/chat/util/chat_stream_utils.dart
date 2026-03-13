import 'package:lanternchat/models/messages/message.dart';
import 'package:lanternchat/models/messages/seen_message.dart';
import 'package:rxdart/rxdart.dart';

import '../../../models/messages/message_tile.dart';

class ChatStreamUtils {
  static Stream<List<MessageTile>> messageTileStream(
    Stream<List<Message>> messageStream,
    Stream<List<SeenMessage>> seenMessageStream,
  ) {
    return Rx.combineLatest2(messageStream, seenMessageStream, (
      List<Message> messages,
      List<SeenMessage> seenMessages,
    ) {
      return seenMessages.map((seenMessage) {
        final message = messages.firstWhere((mess) => seenMessage.seenMessageId.contains(mess.messageId));

        return MessageTile(message: message, seenMessage: seenMessage);
      }).toList();
    });
  }
}
