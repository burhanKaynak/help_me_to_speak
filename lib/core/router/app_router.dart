import 'package:auto_route/annotations.dart';

import '../../views/auth/auth_view/auth_view.dart';
import '../../views/auth/welcome_view/welcome_view.dart';
import '../../views/common/help_center_list_view/help_center_list_view.dart';
import '../../views/common/nationality_selection_view/nationality_selection_main_view.dart';
import '../../views/common/splash_view/splash_view.dart';
import '../../views/conversation/call_view/call_view.dart';
import '../../views/conversation/chat_view/chat_view.dart';
import '../../views/home/home_view.dart';
import '../../views/home/translator_appointment_view/translator_appointment_view.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashView, path: '/splash', initial: true),
    AutoRoute(page: WelcomeView, path: '/welcome'),
    AutoRoute(page: AuthView, path: '/auth'),
    AutoRoute(page: HomeView, path: '/home'),
    AutoRoute(page: ChatView, path: '/chat'),
    AutoRoute(page: HelpCenterListView, path: '/helpCenterList'),
    AutoRoute(page: TranslatorAppointmentView, path: '/appointment'),
    AutoRoute(page: CallView, path: '/call'),
    AutoRoute(
      page: NationalitySelectionView,
      path: '/nationalitySelectionMain',
    )
  ],
)
class $AppRouter {}
