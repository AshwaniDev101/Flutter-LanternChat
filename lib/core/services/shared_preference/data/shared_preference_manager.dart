

import 'package:shared_preferences/shared_preferences.dart';


class SharedData
{
  static const String onlineStatus = 'onlineStatus';
}

class SharedPreferencesManager {
  final SharedPreferences prefs;

  SharedPreferencesManager(this.prefs);

  Future<void> setString(String key, String value) async {
    await prefs.setString(key, value);
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    await prefs.setBool(key, value);
  }

  bool getBool(String key) {
    return prefs.getBool(key) ?? false;
  }

  Future<void> remove(String key) async {
    await prefs.remove(key);
  }
}