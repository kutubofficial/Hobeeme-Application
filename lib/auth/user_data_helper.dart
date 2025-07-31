import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataHelper {
  static const String _userKey = 'users';

  /// ! Save user to shared preferences
  static Future<void> saveUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();

    //* Get existing users
    final usersJson = prefs.getString(_userKey);
    Map<String, dynamic> users = usersJson != null ? jsonDecode(usersJson) : {};

    //* Add new user
    users[email] = password;

    //* Save back to prefs
    prefs.setString(_userKey, jsonEncode(users));
  }

  //! Check if user exists with matching email & password
  static Future<bool> validateUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_userKey);

    if (usersJson == null) return false;

    final users = jsonDecode(usersJson) as Map<String, dynamic>;

    //! Match email and password
    return users.containsKey(email) && users[email] == password;
  }

  //! Optional: Check if email already exists
  static Future<bool> userExists(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(_userKey);

    if (usersJson == null) return false;

    final users = jsonDecode(usersJson) as Map<String, dynamic>;
    return users.containsKey(email);
  }
}
