



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/models/messages/message_tile.dart';

import '../../../../core/firebase/provider/firebase_providers.dart';
import '../data/seen_message_service.dart';
import '../util/chat_stream_utils.dart';
import 'chat_provider.dart';

final seenMessageServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return SeenMessageService(firestore: firestore);
});

// final seenMessageStreamProvider = StreamProvider.family<List<SeenMessage>, String?>((ref, String? conversationId) {
//   if (conversationId == null) {
//     return Stream.value([]);
//   }
//
//   return ref.read(seenMessageServiceProvider).watchSeenMessageStream(conversationId);
// });
//

final seenMessageMergeSteamProvider = StreamProvider.family<List<MessageTile>, String?>((ref,String?  conversationId) {


  if (conversationId == null) {
    return Stream.value([]);
  }

  // currentUid is to filter where 'memberIds'
  final chatStream = ref.watch(chatServiceProvider).watchChatStream(conversationId);
  // currentUid is need to fetch user contact list
  // final conversationsStream = ref.watch(seenMessageServiceProvider).watchSeenMessageStream(conversationId);
  final seenMessageStream = ref.watch(seenMessageServiceProvider).watchSeenMessageStream(conversationId);

  return ChatStreamUtils.messageTileStream(chatStream, seenMessageStream);
});
