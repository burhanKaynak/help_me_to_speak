import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/const/app_sizer.dart';
import '../../../../utils/const/app_spacer.dart';
import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_divider.dart';
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
            child: const Text('Şifremi unuttum'),
          ),
        ),
        buildButton(text: 'Giriş Yap'),
        AppOrDivider(
          height: AppSizer.dividerH,
          tickness: AppSizer.dividerTicknessSmall,
        ),
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
          AppSpacer.verticalSmallSpace,
          AppTextFormField(
            hint: 'Password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          AppSpacer.verticalSmallSpace,
        ],
      ));

  Widget get _buildLoginButtonsForAnotherPlatform => Column(
        children: [
          buildLoginButtonForAnotherPlatform(context,
              icon: const Icon(
                FontAwesomeIcons.google,
              ),
              text: 'Google ile giriş yap'),
          AppSpacer.verticalSmallSpace,
          buildLoginButtonForAnotherPlatform(context,
              color: Colors.white,
              textColor: Colors.black,
              icon: const Icon(
                FontAwesomeIcons.apple,
                color: Colors.black,
              ),
              text: 'Apple ile giriş yap'),
          AppSpacer.verticalSmallSpace,
          buildLoginButtonForAnotherPlatform(
              color: Colors.indigo,
              icon: const Icon(FontAwesomeIcons.facebookF),
              context,
              text: 'Facebook ile giriş yap'),
        ],
      );
}
