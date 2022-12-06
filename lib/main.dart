import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:help_me_to_speak/core/locale/translations.dart';
import 'package:help_me_to_speak/core/utils/utils.dart';

import 'themes/project_theme_manager.dart';
import 'themes/project_themes.dart';
import 'widgets/app_scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: Translations.all,
      path: 'assets/translations',
      startLocale: const Locale.fromSubtags(languageCode: 'tr'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  final ProjectThemeManager _themeManager = ProjectThemeManager();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (_, child) => MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              scrollBehavior: AppScrollBehavior(),
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: _themeManager.themeMode,
              routerDelegate: Utils.appRouter.delegate(),
              routeInformationParser: Utils.appRouter.defaultRouteParser(),
            ));
  }
}
