import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/constant_providers.dart';
import '../data/conversation_service.dart';

final conversationServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ConversationService(firestore: firestore);
});
