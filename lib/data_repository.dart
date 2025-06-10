import 'package:shared_preferences/shared_preferences.dart';

class DataRepository {
  static String loginName = "";
  static String firstName = "";
  static String lastName = "";
  static String phone = "";
  static String email = "";

  static Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("firstName", firstName);
    prefs.setString("lastName", lastName);
    prefs.setString("phone", phone);
    prefs.setString("email", email);
  }

  static Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    firstName = prefs.getString("firstName") ?? "";
    lastName = prefs.getString("lastName") ?? "";
    phone = prefs.getString("phone") ?? "";
    email = prefs.getString("email") ?? "";
  }
}
