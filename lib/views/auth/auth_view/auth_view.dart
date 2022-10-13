import 'package:flutter/material.dart';

import '../../../themes/project_themes.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: padding.bottom,
            top: padding.top * 1.5),
        child: Center(
          child: Column(
            children: [_buildBody, _buildTabBar],
          ),
        ),
      ),
    );
  }

  Widget get _buildTabBar => DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
              labelColor: colorLightGreen,
              indicatorColor: colorLightGreen,
              unselectedLabelColor: Colors.black45,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [Text('Giriş Yap')],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Text(
                        'Kayıt Ol',
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      );

  Widget get _buildBody => const FlutterLogo(
        size: 100,
      );
  Widget get _buildFooter => Column(
        children: [
          // SignInButtonBuilder(
          //   text: 'Sign in with Email',
          //   icon: Icons.email,
          //   onPressed: () {},
          //   shape: _getShape,
          //   backgroundColor: Colors.grey[700]!,
          // ),
          // SignInButton(
          //   Buttons.Google,
          //   text: 'Sign in with Google',
          //   shape: _getShape,
          //   onPressed: () {},
          // ),
          // SignInButton(
          //   Buttons.Apple,
          //   text: 'Sign in with Apple',
          //   shape: _getShape,
          //   onPressed: () {},
          // ),
          // SignInButton(
          //   Buttons.FacebookNew,
          //   text: 'Sign in with Facebook',
          //   shape: _getShape,
          //   onPressed: () {},
          // ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
              onPressed: () => null, child: const Text('Register account'))
        ],
      );

  RoundedRectangleBorder get _getShape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5));
}
