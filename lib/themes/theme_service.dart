import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './theme_config.dart';

class ThemeService {
  ThemeService._();

  static SharedPreferences prefs;
  static ThemeService _instance;
  static Future<ThemeService> get instance async {
    if (_instance == null) {
      prefs = await SharedPreferences.getInstance();
      _instance = ThemeService._();
    }
    return _instance;
  }

  final allThemes = <String, ThemeData>{
    'dark': darkTheme,
    'light': lightTheme,
    'darkBlue': darkBlueTheme,
  };

  get initial {
    String themeName = prefs.getString('theme');
    if (themeName == null) {
      final isPlatformDark =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'dark' : 'light';
    }
    return allThemes[themeName];
  }

  String get previousThemeName {
    String themeName = prefs.getString('previousThemeName');
    if (themeName == null) {
      final isPlatformDark =
          WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
      themeName = isPlatformDark ? 'light' : 'dark';
    }
    return themeName;
  }

  save(String newThemeName) {
    var currentThemeName = prefs.getString('theme');
    prefs.setString('previousThemeName', currentThemeName);
    prefs.setString('theme', newThemeName);
  }

  ThemeData getByName(String name) {
    return allThemes[name];
  }
}
