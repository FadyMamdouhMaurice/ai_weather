import 'package:ai_weather_cellula/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  static const String isLoggedInKey = 'isLoggedIn';
  static const String userKey = 'user';

  static Future<bool> getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(isLoggedInKey) ?? false;
    return isLoggedIn;
  }

  static Future<void> saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userKey, user.toJson().toString());
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(userKey);
    if (userString != null) {
      return UserModel.fromJson(Map<String, dynamic>.from(userString as Map));
    }
    return null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(isLoggedInKey);
    await prefs.remove(userKey);
  }

}
