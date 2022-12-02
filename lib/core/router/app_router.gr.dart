// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../views/auth/auth_view/auth_view.dart' as _i3;
import '../../views/auth/welcome_view/welcome_view.dart' as _i2;
import '../../views/common/nationality_selection_view/nationality_selection_main_view.dart'
    as _i7;
import '../../views/common/splash_view/splash_view.dart' as _i1;
import '../../views/conversation/chat_view/chat_view.dart' as _i5;
import '../../views/home/home_view.dart' as _i4;
import '../../views/home/translator_appointment_view/translator_rezervation_view.dart'
    as _i6;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashView(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.WelcomeView(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.HomeView(),
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.ChatView(
          key: args.key,
          userId: args.userId,
          conversationId: args.conversationId,
        ),
      );
    },
    TranslatorRezervationRoute.name: (routeData) {
      final args = routeData.argsAs<TranslatorRezervationRouteArgs>();
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i6.TranslatorRezervationView(
          key: args.key,
          translatorId: args.translatorId,
        ),
      );
    },
    NationalitySelectionRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.NationalitySelectionView(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        _i8.RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        _i8.RouteConfig(
          WelcomeRoute.name,
          path: '/welcome',
        ),
        _i8.RouteConfig(
          AuthRoute.name,
          path: '/auth',
        ),
        _i8.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i8.RouteConfig(
          ChatRoute.name,
          path: '/chat',
        ),
        _i8.RouteConfig(
          TranslatorRezervationRoute.name,
          path: '/rezervation',
        ),
        _i8.RouteConfig(
          NationalitySelectionRoute.name,
          path: '/nationalitySelectionMain',
        ),
      ];
}

/// generated route for
/// [_i1.SplashView]
class SplashRoute extends _i8.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.WelcomeView]
class WelcomeRoute extends _i8.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/welcome',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i3.AuthView]
class AuthRoute extends _i8.PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: '/auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i4.HomeView]
class HomeRoute extends _i8.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.ChatView]
class ChatRoute extends _i8.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i9.Key? key,
    required String userId,
    required String conversationId,
  }) : super(
          ChatRoute.name,
          path: '/chat',
          args: ChatRouteArgs(
            key: key,
            userId: userId,
            conversationId: conversationId,
          ),
        );

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.userId,
    required this.conversationId,
  });

  final _i9.Key? key;

  final String userId;

  final String conversationId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, userId: $userId, conversationId: $conversationId}';
  }
}

/// generated route for
/// [_i6.TranslatorRezervationView]
class TranslatorRezervationRoute
    extends _i8.PageRouteInfo<TranslatorRezervationRouteArgs> {
  TranslatorRezervationRoute({
    _i9.Key? key,
    required String translatorId,
  }) : super(
          TranslatorRezervationRoute.name,
          path: '/rezervation',
          args: TranslatorRezervationRouteArgs(
            key: key,
            translatorId: translatorId,
          ),
        );

  static const String name = 'TranslatorRezervationRoute';
}

class TranslatorRezervationRouteArgs {
  const TranslatorRezervationRouteArgs({
    this.key,
    required this.translatorId,
  });

  final _i9.Key? key;

  final String translatorId;

  @override
  String toString() {
    return 'TranslatorRezervationRouteArgs{key: $key, translatorId: $translatorId}';
  }
}

/// generated route for
/// [_i7.NationalitySelectionView]
class NationalitySelectionRoute extends _i8.PageRouteInfo<void> {
  const NationalitySelectionRoute()
      : super(
          NationalitySelectionRoute.name,
          path: '/nationalitySelectionMain',
        );

  static const String name = 'NationalitySelectionRoute';
}
