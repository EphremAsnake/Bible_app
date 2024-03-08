import 'dart:convert';
import 'package:hive/hive.dart';

import '../utils/customsnackbar.dart';

class CacheStorageService {
  CacheStorageService();

  static final _storage = Hive.box('bible_app');

  //Get permanently saved objects
  Future<Map<String, dynamic>?> getSavedData(String key) async {
    try {
      if (key.isEmpty) return null;
      var response = await _storage.get(key);
      if (response != null) {
        return json.decode(response);
      } else {
        return null;
      }
    } catch (ex) {
      customSnackBar(title: 'Error', body: "Error Occurred while caching data");
      return null;
    }
  }

  //Save permanently
  Future saveData(String key, Map<String, dynamic> value) async {
    try {
      if (key.isEmpty) return null;
      var a = json.encode(value);
      await _storage.put(key, a);
    } catch (ex) {
      customSnackBar(
          title: 'Error', body: "Error Occurred while reading cache data");
    }
  }
}
