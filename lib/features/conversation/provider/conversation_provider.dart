import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/models/conversations/conversation_meta.dart';

import '../../../core/firestore/provider/firestore_provider.dart';
import '../../../models/conversations/conversation.dart';
import '../data/conversation_service.dart';

final conversationServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ConversationService(firestore: firestore);
});

final conversationSteamProvider = StreamProvider.family<List<Conversation>, String>((ref, uid) {
  return ref.watch(conversationServiceProvider).conversationStream(uid);
});
