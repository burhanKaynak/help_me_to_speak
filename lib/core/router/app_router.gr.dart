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
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;

import '../../views/auth/auth_view/auth_view.dart' as _i3;
import '../../views/auth/welcome_view/welcome_view.dart' as _i2;
import '../../views/common/help_center_list_view/help_center_list_view.dart'
    as _i6;
import '../../views/common/nationality_selection_view/nationality_selection_main_view.dart'
    as _i9;
import '../../views/common/splash_view/splash_view.dart' as _i1;
import '../../views/conversation/call_view/call_view.dart' as _i8;
import '../../views/conversation/chat_view/chat_view.dart' as _i5;
import '../../views/home/home_view.dart' as _i4;
import '../../views/home/translator_appointment_view/translator_appointment_view.dart'
    as _i7;
import '../enum/call_type_enum.dart' as _i13;
import '../enum/conversation_type_enum.dart' as _i15;
import '../models/response/call_model.dart' as _i14;
import '../models/response/customer_model.dart' as _i12;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.SplashView(),
      );
    },
    WelcomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.WelcomeView(),
      );
    },
    AuthRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.AuthView(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.HomeView(),
      );
    },
    ChatRoute.name: (routeData) {
      final args = routeData.argsAs<ChatRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.ChatView(
          key: args.key,
          translator: args.translator,
          conversationId: args.conversationId,
        ),
      );
    },
    HelpCenterListRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.HelpCenterListView(),
      );
    },
    TranslatorAppointmentRoute.name: (routeData) {
      final args = routeData.argsAs<TranslatorAppointmentRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i7.TranslatorAppointmentView(
          key: args.key,
          translatorId: args.translatorId,
        ),
      );
    },
    CallRoute.name: (routeData) {
      final args = routeData.argsAs<CallRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i8.CallView(
          key: args.key,
          conversationId: args.conversationId,
          callType: args.callType,
          customer: args.customer,
          call: args.call,
          conversationType: args.conversationType,
        ),
      );
    },
    NationalitySelectionRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.NationalitySelectionView(),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/splash',
          fullMatch: true,
        ),
        _i10.RouteConfig(
          SplashRoute.name,
          path: '/splash',
        ),
        _i10.RouteConfig(
          WelcomeRoute.name,
          path: '/welcome',
        ),
        _i10.RouteConfig(
          AuthRoute.name,
          path: '/auth',
        ),
        _i10.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i10.RouteConfig(
          ChatRoute.name,
          path: '/chat',
        ),
        _i10.RouteConfig(
          HelpCenterListRoute.name,
          path: '/helpCenterList',
        ),
        _i10.RouteConfig(
          TranslatorAppointmentRoute.name,
          path: '/appointment',
        ),
        _i10.RouteConfig(
          CallRoute.name,
          path: '/call',
        ),
        _i10.RouteConfig(
          NationalitySelectionRoute.name,
          path: '/nationalitySelectionMain',
        ),
      ];
}

/// generated route for
/// [_i1.SplashView]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute()
      : super(
          SplashRoute.name,
          path: '/splash',
        );

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.WelcomeView]
class WelcomeRoute extends _i10.PageRouteInfo<void> {
  const WelcomeRoute()
      : super(
          WelcomeRoute.name,
          path: '/welcome',
        );

  static const String name = 'WelcomeRoute';
}

/// generated route for
/// [_i3.AuthView]
class AuthRoute extends _i10.PageRouteInfo<void> {
  const AuthRoute()
      : super(
          AuthRoute.name,
          path: '/auth',
        );

  static const String name = 'AuthRoute';
}

/// generated route for
/// [_i4.HomeView]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.ChatView]
class ChatRoute extends _i10.PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    _i11.Key? key,
    required _i12.Customer translator,
    required String conversationId,
  }) : super(
          ChatRoute.name,
          path: '/chat',
          args: ChatRouteArgs(
            key: key,
            translator: translator,
            conversationId: conversationId,
          ),
        );

  static const String name = 'ChatRoute';
}

class ChatRouteArgs {
  const ChatRouteArgs({
    this.key,
    required this.translator,
    required this.conversationId,
  });

  final _i11.Key? key;

  final _i12.Customer translator;

  final String conversationId;

  @override
  String toString() {
    return 'ChatRouteArgs{key: $key, translator: $translator, conversationId: $conversationId}';
  }
}

/// generated route for
/// [_i6.HelpCenterListView]
class HelpCenterListRoute extends _i10.PageRouteInfo<void> {
  const HelpCenterListRoute()
      : super(
          HelpCenterListRoute.name,
          path: '/helpCenterList',
        );

  static const String name = 'HelpCenterListRoute';
}

/// generated route for
/// [_i7.TranslatorAppointmentView]
class TranslatorAppointmentRoute
    extends _i10.PageRouteInfo<TranslatorAppointmentRouteArgs> {
  TranslatorAppointmentRoute({
    _i11.Key? key,
    required String translatorId,
  }) : super(
          TranslatorAppointmentRoute.name,
          path: '/appointment',
          args: TranslatorAppointmentRouteArgs(
            key: key,
            translatorId: translatorId,
          ),
        );

  static const String name = 'TranslatorAppointmentRoute';
}

class TranslatorAppointmentRouteArgs {
  const TranslatorAppointmentRouteArgs({
    this.key,
    required this.translatorId,
  });

  final _i11.Key? key;

  final String translatorId;

  @override
  String toString() {
    return 'TranslatorAppointmentRouteArgs{key: $key, translatorId: $translatorId}';
  }
}

/// generated route for
/// [_i8.CallView]
class CallRoute extends _i10.PageRouteInfo<CallRouteArgs> {
  CallRoute({
    _i11.Key? key,
    required String conversationId,
    required _i13.CallType callType,
    required _i12.Customer customer,
    required _i14.Call call,
    required _i15.ConversationType conversationType,
  }) : super(
          CallRoute.name,
          path: '/call',
          args: CallRouteArgs(
            key: key,
            conversationId: conversationId,
            callType: callType,
            customer: customer,
            call: call,
            conversationType: conversationType,
          ),
        );

  static const String name = 'CallRoute';
}

class CallRouteArgs {
  const CallRouteArgs({
    this.key,
    required this.conversationId,
    required this.callType,
    required this.customer,
    required this.call,
    required this.conversationType,
  });

  final _i11.Key? key;

  final String conversationId;

  final _i13.CallType callType;

  final _i12.Customer customer;

  final _i14.Call call;

  final _i15.ConversationType conversationType;

  @override
  String toString() {
    return 'CallRouteArgs{key: $key, conversationId: $conversationId, callType: $callType, customer: $customer, call: $call, conversationType: $conversationType}';
  }
}

/// generated route for
/// [_i9.NationalitySelectionView]
class NationalitySelectionRoute extends _i10.PageRouteInfo<void> {
  const NationalitySelectionRoute()
      : super(
          NationalitySelectionRoute.name,
          path: '/nationalitySelectionMain',
        );

  static const String name = 'NationalitySelectionRoute';
}
