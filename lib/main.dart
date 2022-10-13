import 'package:flutter/material.dart';
import 'package:help_me_to_speak/views/auth/auth_view/auth_view.dart';

import 'themes/project_theme_manager.dart';
import 'themes/project_themes.dart';
import 'widgets/app_scroll_behavior.dart';

void main() {
  runApp(const MyApp());
}

ProjectThemeManager _themeManager = ProjectThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: AppScrollBehavior(),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: const AuthView(),
    );
  }
}
