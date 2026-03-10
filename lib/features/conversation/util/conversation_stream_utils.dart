import 'package:rxdart/rxdart.dart';

import '../../../../models/conversations/conversation.dart';
import '../../../../models/conversations/conversation_tile.dart';
import '../../../../models/users/contact.dart';

class ConversationStreamUtils {
  static Stream<List<ConversationTile>> conversationsTileStream(
    Stream<List<Contact>> contactsStream,
    Stream<List<Conversation>> conversationsStream,
  ) {
    return Rx.combineLatest2(contactsStream, conversationsStream, (
      List<Contact> contacts,
      List<Conversation> conversations,
    ) {
      return contacts.map((contact) {
        final conversation = conversations.firstWhere((conversation) => conversation.id == contact.conversationId);

        return ConversationTile(contact: contact, conversation: conversation);
      }).toList();
    });
  }


/// Old Example
/// Merges the global initiatives with their daily completion states,
/// and sorts them by the completion timestamp.
// Stream<List<Initiative>> get mergedDayInitiatives {
//   return Rx.combineLatest2<
//       Map<String, InitiativeCompletion>,
//       List<Initiative>,
//       List<Initiative>>(
//     schedule$, // Stream of completion data for a given day
//     GlobalListManager.instance.watch(), // Stream of all global initiatives
//         (dailyMap, globalList) {
//       // keep only initiatives that exist in the daily map (completed ones)
//       final merged = globalList
//           .where((i) => dailyMap.containsKey(i.id))
//           .map((i) {
//         final completion = dailyMap[i.id]!;
//         // merge initiative data with its completion state
//         return i.copyWith(
//           isComplete: completion.isComplete,
//           timestamp: completion.timestamp,
//         );
//       })
//           .toList();
//
//       // sort by completion timestamp (oldest → newest)
//       merged.sort((a, b) => a.timestamp.compareTo(b.timestamp));
//
//       return merged;
//     },
//   );
// }
}
