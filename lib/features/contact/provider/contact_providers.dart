// For Connection DB
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/firestore/provider/firestore_provider.dart';
import '../../../models/users/app_user.dart';
import '../../../models/users/contact.dart';
import '../../auth/provider/auth_provider.dart';
import '../data/contact_service.dart';

final contactServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ContactService(firestore: firestore);
});

final contactStreamProvider = StreamProvider<List<Contact>>((ref) {
  // final currentUser = ref.watch(firebaseAuthProvider).currentUser;
  final currentUser = ref.watch(currentUserProvider);

  final service = ref.read(contactServiceProvider);
  return service.watchContacts(uid: currentUser.uid);
});
