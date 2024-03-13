import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage{
  // Singleton instance of the class
  static final SharedPreferencesStorage _instance = SharedPreferencesStorage._internal();

  factory SharedPreferencesStorage() {
    return _instance;
  }

  SharedPreferencesStorage._internal();

  // Save an int value
  Future<void> saveIntData(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  // Read an int value
  Future<int?> readIntData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  // Save a string value
  Future<void> saveStringData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Read a string value
  Future<String?> readStringData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Save a boolean value
  Future<void> saveBoolData(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Read a boolean value
  Future<bool?> readBoolData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}