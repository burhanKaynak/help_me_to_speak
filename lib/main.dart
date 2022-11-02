import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'themes/project_theme_manager.dart';
import 'themes/project_themes.dart';
import 'views/auth/country_selection_view/country_selection_view.dart';
import 'widgets/app_scroll_behavior.dart';

void main() {
  runApp(const MyApp());
}

ProjectThemeManager _themeManager = ProjectThemeManager();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (_, child) => MaterialApp(
              scrollBehavior: AppScrollBehavior(),
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: _themeManager.themeMode,
              home: const CountrySelectionView(),
            ));
  }
}
