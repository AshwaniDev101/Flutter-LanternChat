import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/shared_preference/data/shared_preference_manager.dart';
import '../../../../core/services/shared_preference/provider/shared_preference_provider.dart';
import '../../../auth/provider/auth_provider.dart';
import '../../../auth/provider/presence_provider.dart';

class SettingsViewModel extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> toggleVisibility(String uid) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      final spp = ref.read(sharedPreferencesProvider);

      final bool newValue = !(spp.getBool(SharedData.onlineStatus) ?? true);

      spp.setBool(SharedData.onlineStatus, newValue);

      ref.read(presenceServiceProvider).setOnlineStatus(uid: uid, isOnline: newValue);
    });
  }

  Future<void> logout() async {
    await ref.read(authManagerProvider).signOut();
  }
}

final settingsViewModelProvider = AsyncNotifierProvider<SettingsViewModel, void>(() => SettingsViewModel());
