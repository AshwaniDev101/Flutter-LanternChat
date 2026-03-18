import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lanternchat/core/services/shared_preference/data/shared_preference_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';


final preferenceProvider = Provider<SharedPreferencesManager>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SharedPreferencesManager(prefs);
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(); // will be overridden in main
});
