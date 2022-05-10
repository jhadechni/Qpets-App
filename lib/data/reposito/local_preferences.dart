 import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  @override
  Future<T?> retrieveData<T>(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic value;
    switch (T) {
      case bool:
        value = prefs.getBool(key);
        print("LocalPreferences getBool with key $key got $value");
        break;
      case double:
        value = prefs.getDouble(key);
        break;
      case int:
        value = prefs.getInt(key);
        break;
      case String:
        value = prefs.getString(key);
        break;
      case List:
        value = prefs.getStringList(key);
        break;
    }
    return value as T?;
  }

  @override
  Future<void> storeData<T>(String key, T value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    switch (T) {
      case bool:
        prefs.setBool(key, value as bool);
        print("LocalPreferences setBool with key $key got $value");
        break;
      case double:
        prefs.setDouble(key, value as double);
        break;
      case int:
        prefs.setInt(key, value as int);
        break;
      case String:
        prefs.setString(key, value as String);
        break;
      case List:
        prefs.setStringList(key, value as List<String>);
        break;
    }
  }
}