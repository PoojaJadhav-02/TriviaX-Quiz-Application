import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';

class StorageService {
  static Future<bool> getIsDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.themeKey) ?? false;
  }

  static Future<void> setIsDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.themeKey, value);
  }

  static Future<String?> getCustomQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.customQuestionsKey);
  }

  static Future<void> setCustomQuestions(String json) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.customQuestionsKey, json);
  }
}