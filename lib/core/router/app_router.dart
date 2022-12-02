import 'package:auto_route/annotations.dart';
import 'package:help_me_to_speak/views/auth/auth_view/auth_view.dart';
import 'package:help_me_to_speak/views/auth/welcome_view/welcome_view.dart';
import 'package:help_me_to_speak/views/common/splash_view/splash_view.dart';
import 'package:help_me_to_speak/views/conversation/chat_view/chat_view.dart';
import 'package:help_me_to_speak/views/home/home_view.dart';
import 'package:help_me_to_speak/views/home/translator_appointment_view/translator_rezervation_view.dart';

import '../../views/common/nationality_selection_view/nationality_selection_main_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashView, path: '/splash', initial: true),
    AutoRoute(page: WelcomeView, path: '/welcome'),
    AutoRoute(page: AuthView, path: '/auth'),
    AutoRoute(page: HomeView, path: '/home'),
    AutoRoute(page: ChatView, path: '/chat'),
    AutoRoute(page: TranslatorRezervationView, path: '/rezervation'),
    AutoRoute(
      page: NationalitySelectionView,
      path: '/nationalitySelectionMain',
    )
  ],
)
class $AppRouter {}
