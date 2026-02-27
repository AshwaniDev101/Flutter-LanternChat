import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/providers/constant_providers.dart';

import 'firebase/conversation_service.dart';
import 'firebase/messages_service.dart';
import 'firebase/user_service.dart';

final userFirestoreServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return UserService(firestore: firestore);
});


final messagesServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return MessagesService(firestore: firestore);
});

final conversationServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ConversationService(firestore: firestore);
});


