import 'package:flutter/material.dart';

class ProjectThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  toogleTheme(Brightness brightness) {
    _themeMode =
        brightness == Brightness.light ? ThemeMode.light : ThemeMode.dark;
  }
}
