import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/themes/project_themes.dart';
import 'package:im_stepper/stepper.dart';

import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_divider.dart';
import '../../../../widgets/app_input.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSignUpForm,
        buildButton(text: 'Kayıt Ol'),
        const AppDivider(),
        _buildLoginButtonsForAnotherPlatform,
      ],
    );
  }

  Widget get _buildSignUpForm => Form(
          child: Column(
        children: [
          _buildStep,
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  hint: 'İsim',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: AppTextFormField(
                  hint: 'Soy ismi',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
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
      ));

  Widget get _buildLoginButtonsForAnotherPlatform => Column(
        children: [
          buildLoginButtonForAnotherPlatform(context,
              icon: const Icon(
                FontAwesomeIcons.google,
              ),
              text: 'Google ile kayıt ol'),
          buildLoginButtonForAnotherPlatform(context,
              color: Colors.white,
              textColor: Colors.black,
              icon: const Icon(
                FontAwesomeIcons.apple,
                color: Colors.black,
              ),
              text: 'Apple ile kayıt ol'),
          buildLoginButtonForAnotherPlatform(
              color: Colors.indigo,
              icon: const Icon(FontAwesomeIcons.facebookF),
              context,
              text: 'Facebook ile kayıt ol'),
        ],
      );

  Widget get _buildStep => DotStepper(
        dotCount: 3,
        dotRadius: 8,
        shape: Shape.circle,
        spacing: 20,
        indicator: Indicator.worm,
        indicatorDecoration: IndicatorDecoration(color: colorLightGreen),
        activeStep: 0,
      );
}
