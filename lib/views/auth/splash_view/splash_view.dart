import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:help_me_to_speak/core/enum/app_route_path_enum.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    var user = AuthService.instance.currentUser;
    if (user != null) {
      context.router.replaceNamed(RoutePath.home.value);
    } else {
      context.router.replaceNamed(RoutePath.welcome.value);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: AuthService.instance.setCustomer(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!) {
                context.router.replaceNamed(RoutePath.home.value);
              } else {
                context.router.replaceNamed(RoutePath.welcome.value);
              }
            }
            return const Center(
                child: FlutterLogo(
              size: 150,
            ));
          }),
    );
  }
}
