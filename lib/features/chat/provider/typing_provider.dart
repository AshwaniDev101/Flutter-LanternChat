import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/features/chat/data/typing_service.dart';

import '../../../core/firebase/provider/firebase_providers.dart';

final typingServiceProvider = Provider((ref) {
  final realtimeDb = ref.watch(realtimeDbProvider);
  return TypingService(realtimeDb);
});
