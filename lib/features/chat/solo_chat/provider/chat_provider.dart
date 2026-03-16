import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/firebase/provider/firebase_providers.dart';
import '../data/chat_service.dart';

final chatServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ChatService(firestore: firestore);
});

// final chatStreamProvider = StreamProvider.family<List<Message>, String?>((ref, String? conversationId) {
//   if (conversationId == null) {
//     return Stream.value([]);
//   }
//
//   return ref.read(chatServiceProvider).watchChatStream(conversationId);
// });

// final chatStreamProvider = StreamProvider.family<List<Message>, String>((ref, String conversationID) {
//   return ref.read(chatServiceProvider).chatStream(conversationID);
// });
