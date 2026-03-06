
// For Connection DB
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/constant_providers.dart';
import '../../../models/users/app_user.dart';
import '../data/connection_service.dart';

final connectionServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ConnectionService(firestore: firestore);
});


final connectionsStreamProvider = StreamProvider.family<List<AppUser>, String>((ref, uid) {

  final service = ref.read(connectionServiceProvider);
  return service.getConnections(uid);
});
