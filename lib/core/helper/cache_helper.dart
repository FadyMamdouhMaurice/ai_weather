import 'package:ai_weather/core/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  Future<String?> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppStrings.token);
  }

  Future<int?> readUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(AppStrings.userId);
  }

  Future<void> writeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppStrings.token, token);
  }

  Future<void> writeUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(AppStrings.userId, userId);
  }

  Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppStrings.token);
  }
}