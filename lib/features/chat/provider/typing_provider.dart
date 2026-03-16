import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/provider/firebase_providers.dart';
import '../data/typing_service.dart';

final typingServiceProvider = Provider((ref) {
  final realtimeDb = ref.watch(realtimeDbProvider);
  return TypingService(realtimeDb);
});

// class TypingTo {
//   final String conversationId;
//   final String uid;
//
//   TypingTo({required this.conversationId, required this.uid});
//
//
//   @override
//   bool operator ==(Object other) {
//     return other is TypingTo &&
//         other.conversationId == conversationId &&
//         other.uid == uid;
//   }
//
//   @override
//   int get hashCode => Object.hash(conversationId, uid);
// }


final typingStreamProvider = StreamProvider.family<DatabaseEvent, String>((ref, String conversationId) {
  final realtimeDb = ref.watch(realtimeDbProvider);
  final dataEvents = TypingService(
    realtimeDb,
  ).watchTyping(conversationId: conversationId);

  return dataEvents;
});
