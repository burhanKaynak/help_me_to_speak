import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      context.router.replaceNamed('/home');
    } else {
      context.router.replaceNamed('/welcome');
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: FlutterLogo(
        size: 150,
      )),
    );
  }
}
