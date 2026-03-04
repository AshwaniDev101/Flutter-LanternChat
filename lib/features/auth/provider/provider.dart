import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/providers/constant_providers.dart';

import '../data/app_service.dart';
import '../auth_manager.dart';


final appServiceProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  return AppService(firestore: firestore);
});

final authManagerProvider = Provider((ref) {
  final auth = ref.watch(firebaseAuthProvider);
  return AuthManager(auth);
});








