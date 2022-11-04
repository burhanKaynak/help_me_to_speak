import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router/app_router.gr.dart';
import 'themes/project_theme_manager.dart';
import 'themes/project_themes.dart';
import 'widgets/app_scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ProjectThemeManager _themeManager = ProjectThemeManager();
  final _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (_, child) => MaterialApp.router(
              scrollBehavior: AppScrollBehavior(),
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: _themeManager.themeMode,
              routerDelegate: _appRouter.delegate(),
              routeInformationParser: _appRouter.defaultRouteParser(),
            ));
  }
}
