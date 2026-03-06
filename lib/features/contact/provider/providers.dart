
// For Connection DB
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/constant_providers.dart';
import '../../../models/users/app_user.dart';
import '../data/contact_service.dart';

final contactServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ContactService(firestore: firestore);
});


final contactStreamProvider = StreamProvider.family<List<AppUser>, String>((ref, uid) {

  final service = ref.read(contactServiceProvider);
  return service.getConnections(uid);
});
