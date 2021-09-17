import 'package:covid19app/constants/data.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  Map<String, dynamic> _appLanguage = languages['en'];

  Map<String, dynamic> get appLanguage => _appLanguage;

  Future<Map<String, dynamic>> get savedAppLanguage async {
    final preferences = await SharedPreferences.getInstance();

    final langCode = preferences.getString('lang') ?? 'en';
    print(langCode);
    _appLanguage = languages[langCode];
    return _appLanguage;
  }

  Future<void> changeLanguage(Map<String, dynamic> lang) async {
    final preferences = await SharedPreferences.getInstance();

    _appLanguage = lang;
    preferences.setString('lang', _appLanguage['code']);
    notifyListeners();
  }
}
