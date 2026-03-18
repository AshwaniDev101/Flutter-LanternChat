import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/firebase/provider/firebase_providers.dart';
import '../data/typing_service.dart';

final typingServiceProvider = Provider((ref) {
  final realtimeDb = ref.watch(firebaseDatabaseProvider);
  return TypingService(realtimeDb);
});


final typingStreamProvider = StreamProvider.family<DatabaseEvent, String>((ref, String conversationId) {
  final realtimeDb = ref.watch(firebaseDatabaseProvider);
  final dataEvents = TypingService(
    realtimeDb,
  ).watchTyping(conversationId: conversationId);

  return dataEvents;
});
