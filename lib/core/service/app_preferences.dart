import 'package:shared_preferences/shared_preferences.dart';

abstract class IAppPreferences {
  Future<String?> get(String key);
  Future<bool> post(String key, String value);
  Future<List<String>> getList(String key);
  Future setList(String key, List<String> list);
  Future<bool> put(String key, String value);
  Future<bool> delete(String key);
}

class AppPreferences implements IAppPreferences {
  final SharedPreferences preferences;

  AppPreferences(this.preferences);

  @override
  Future<List<String>> getList(String key) async =>
      preferences.getStringList(key) ?? List<String>.empty(growable: true);

  @override
  Future setList(String key, List<String> list) {
    return preferences.setStringList(key, list);
  }

  @override
  Future<String?> get(String key) async => preferences.getString(key);

  @override
  Future<bool> post(String key, String value) =>
      preferences.setString(key, value);

  @override
  Future<bool> put(String key, String value) =>
      preferences.setString(key, value);

  @override
  Future<bool> delete(String key) => preferences.remove(key);
}
