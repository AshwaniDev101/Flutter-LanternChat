import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/firestore/provider/firestore_provider.dart';
import '../data/home_conversation_service.dart';

final conversationServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return HomeConversationService(firestore: firestore);
});
