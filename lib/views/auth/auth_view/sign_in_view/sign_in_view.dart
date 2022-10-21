import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/widgets/app_divider.dart';

import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_input.dart';

class SingInView extends StatefulWidget {
  const SingInView({super.key});

  @override
  State<SingInView> createState() => _SingInViewState();
}

class _SingInViewState extends State<SingInView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSignUpForm,
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => null,
            child: Text('Şifremi unuttum'),
          ),
        ),
        buildButton(text: 'Giriş Yap'),
        const AppDivider(),
        _buildLoginButtonsForAnotherPlatform,
      ],
    );
  }

  Widget get _buildSignUpForm => Form(
          child: Column(
        children: [
          AppTextFormField(
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          10.verticalSpace,
          AppTextFormField(
            hint: 'Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          10.verticalSpace,
        ],
      ));

  Widget get _buildLoginButtonsForAnotherPlatform => Column(
        children: [
          buildLoginButtonForAnotherPlatform(context,
              icon: const Icon(
                FontAwesomeIcons.google,
              ),
              text: 'Google ile giriş yap'),
          5.verticalSpace,
          buildLoginButtonForAnotherPlatform(context,
              color: Colors.white,
              textColor: Colors.black,
              icon: const Icon(
                FontAwesomeIcons.apple,
                color: Colors.black,
              ),
              text: 'Apple ile giriş yap'),
          5.verticalSpace,
          buildLoginButtonForAnotherPlatform(
              color: Colors.indigo,
              icon: const Icon(FontAwesomeIcons.facebookF),
              context,
              text: 'Facebook ile giriş yap'),
        ],
      );
}
