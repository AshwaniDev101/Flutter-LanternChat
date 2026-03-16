// For Connection DB
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/firebase/provider/firebase_providers.dart';
import '../../../models/users/app_user.dart';
import '../../../models/users/contact.dart';
import '../../auth/provider/auth_provider.dart';
import '../../chat/provider/chat_provider.dart';
import '../data/contact_service.dart';

final contactServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ContactService(firestore: firestore);
});


// Todo we can get rid of contactStreamProvider since we have contact lookup table
final contactStreamProvider = StreamProvider<List<Contact>>((ref) {
  // final currentUser = ref.watch(firebaseAuthProvider).currentUser;
  final currentUser = ref.watch(currentUserProvider);

  final service = ref.read(contactServiceProvider);
  return service.watchContacts(uid: currentUser.uid);
});


/// Return a nice Map of contacts
final contactsMapProvider = Provider<Map<String, Contact>>((ref) {
  final List<Contact> contacts = ref.watch(contactStreamProvider).value ?? [];

  return {for (final c in contacts) c.uid: c};
});
// final contactsMapProvider = Provider<Map<String, Contact>?>((ref) {
//   final contactsAsync = ref.watch(contactStreamProvider);
//
//   return contactsAsync.valueOrNull?.fold(<String, Contact>{}, (map, contact) {
//     map?[contact.uid] = contact;
//     return map;
//   });
// });
