import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/conversation/util/conversation_stream_utils.dart';
import 'package:lanternchat/features/contact/provider/contact_providers.dart';
import 'package:lanternchat/models/conversations/conversation_entry.dart';
import '../../../core/services/firebase/provider/firebase_providers.dart';
import '../data/conversation_service.dart';

final conversationServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ConversationService(firestore: firestore);
});

// final conversationSteamProvider = StreamProvider.family<List<Conversation>, String>((ref, String memberIds) {
//   return ref.watch(conversationServiceProvider).conversationStream(memberIds);
// });

final conversationContactMergeSteamProvider = StreamProvider.family<List<ConversationEntry>, String>((ref, currentUid) {
  // currentUid is to filter where 'memberIds'
  final contactsStream = ref.watch(contactServiceProvider).watchContacts(uid: currentUid);
  // currentUid is need to fetch user contact list
  final conversationsStream = ref.watch(conversationServiceProvider).conversationStream(memberId: currentUid);

  return ConversationStreamUtils.conversationsTileStream(contactsStream, conversationsStream);
});
