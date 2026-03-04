import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/models/message.dart';

import '../../../core/providers/constant_providers.dart';
import '../data/chat_service.dart';

final chatServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ChatService(firestore: firestore);
});


final chatStreamProvider = StreamProvider.family<List<Message>, String>((ref,String conversationID){

  return ref.read(chatServiceProvider).chatStream(conversationID);
});