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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../../views/auth/auth_view/auth_view.dart' as _i3;
import '../../views/auth/splash_view/splash_view.dart' as _i1;
import '../../views/auth/welcome_view/welcome_view.dart' as _i2;
import '../../views/conversation/chat_view/chat_view.dart' as _i5;
import '../../views/home/home_view.dart' as _i4;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashView(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.WelcomeView(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.HomeView(),
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.ChatView(
          key: args.key,
          userId: args.userId,
          conversationId: args.conversationId,
        ),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        _i6.RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        _i6.RouteConfig(
          WelcomeRoute.name,
          path: '/welcome',
        ),
        _i6.RouteConfig(
          AuthRoute.name,
          path: '/auth',
        ),
        _i6.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i6.RouteConfig(
          ChatRoute.name,
          path: '/chat',
        ),
      ];
}

/// generated route for
/// [_i1.SplashView]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.WelcomeView]
class WelcomeRoute extends _i6.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/welcome',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i3.AuthView]
class AuthRoute extends _i6.PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: '/auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i4.HomeView]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.ChatView]
class ChatRoute extends _i6.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i7.Key? key,
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

  final _i7.Key? key;

  final String userId;

  final String conversationId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, userId: $userId, conversationId: $conversationId}';
  }
}
