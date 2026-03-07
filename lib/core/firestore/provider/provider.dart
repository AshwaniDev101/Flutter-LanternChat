import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/constant_providers.dart';
import '../data/firestore_service.dart';

final appServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return FireStoreService(firestore: firestore);
});
