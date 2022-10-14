import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/widgets/app_buttons.dart';

import '../../../themes/project_themes.dart';
import '../../../widgets/app_input.dart';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: _buildLogo),
              Form(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppTextFormField(
                    hint: 'Email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AppTextFormField(
                    hint: 'Password',
                    obscureText: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )),
              buildButton(text: 'Giriş Yap'),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Expanded(
                    child: Divider(
                      height: 0.5,
                      thickness: 1.5,
                      color: colorHint,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text('Veya',
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2!
                            .copyWith(color: colorHint)),
                  ),
                  const Expanded(
                    child: Divider(
                      height: 0.5,
                      thickness: 1.5,
                      color: colorHint,
                    ),
                  ),
                ],
              ),
              buildLoginButtonForAnotherPlatform(context,
                  icon: Icon(
                    FontAwesomeIcons.google,
                  ),
                  text: 'Google ile giriş yap'),
              buildLoginButtonForAnotherPlatform(context,
                  color: Colors.white,
                  textColor: Colors.black,
                  icon: Icon(
                    FontAwesomeIcons.apple,
                    color: Colors.black,
                  ),
                  text: 'Apple ile giriş yap'),
              buildLoginButtonForAnotherPlatform(
                  color: Colors.indigo,
                  icon: Icon(FontAwesomeIcons.facebookF),
                  context,
                  text: 'Facebook ile giriş yap'),
              TextButton(onPressed: () => null, child: Text('Hesap oluştur'))
            ],
          ),
        ),
      ),
    );
  }

  Widget get _buildLogo => Padding(
        padding: const EdgeInsets.all(50.0),
        child: const FlutterLogo(
          size: 100,
        ),
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
