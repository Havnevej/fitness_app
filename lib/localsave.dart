import 'package:shared_preferences/shared_preferences.dart';


class LocalSave {

  static void save(String key, dynamic value) async {
    final SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    if (value is bool) {
      await sharedPrefs.setBool(key, value);
    } else if (value is String) {
      await sharedPrefs.setString(key, value);
    } else if (value is int) {
      await sharedPrefs.setInt(key, value);
    } else if (value is double) {
      await sharedPrefs.setDouble(key, value);
    } else if (value is List<String>) {
      await sharedPrefs.setStringList(key, value);
    }
  }
}