// For Connection DB
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/services/firebase/provider/firebase_providers.dart';
import '../../../models/users/contact.dart';
import '../../auth/provider/auth_provider.dart';
import '../data/contact_service.dart';

final Provider<ContactService> contactServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return ContactService(firestore: firestore);
});

// It create a provider for the steam
final StreamProvider<List<Contact>> contactStreamProvider = StreamProvider<List<Contact>>((ref) {
  // final currentUser = ref.watch(firebaseAuthProvider).currentUser;
  final currentUser = ref.watch(currentUserProvider);

  final service = ref.watch(contactServiceProvider);
  return service.watchContacts(uid: currentUser.uid);
});

/// Return a nice Map of contacts, using a steam updates automatically
final Provider<Map<String, Contact>> contactsMapProvider = Provider<Map<String, Contact>>((ref) {
  final List<Contact> contacts = ref.watch(contactStreamProvider).value ?? [];

  return {for (final c in contacts) c.uid: c};
});

