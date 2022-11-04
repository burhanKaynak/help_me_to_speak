import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/core/const/app_padding.dart';
import 'package:help_me_to_speak/core/enum/app_route_path_enum.dart';
import 'package:help_me_to_speak/core/error/auth_exeption_handler.dart';
import 'package:help_me_to_speak/core/models/request/login_model.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';
import 'package:help_me_to_speak/themes/project_themes.dart';

import '../../../../core/const/app_sizer.dart';
import '../../../../core/const/app_spacer.dart';
import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_divider.dart';
import '../../../../widgets/app_input.dart';

class SingInView extends StatefulWidget {
  const SingInView({super.key});

  @override
  State<SingInView> createState() => _SingInViewState();
}

class _SingInViewState extends State<SingInView> {
  final _loginFormKey = GlobalKey<FormState>();
  final _forgotPasswordformKey = GlobalKey<FormState>();
  final _loginModel = LoginModel(email: '', password: '');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSignUpForm,
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => showBottomSheet(
              context: context,
              builder: (context) => Container(
                padding: AppPadding.layoutPadding,
                height: AppSizer.bottomSheetSmall,
                color: colorBackground,
                child: Form(
                  key: _forgotPasswordformKey,
                  child: Column(
                    children: [
                      AppTextFormField(
                        onSaved: (val) => _loginModel.email = val,
                        hint: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      AppSpacer.verticalMediumSpace,
                      buildButton(
                          onPressed: _submitForgotPasswordForm, text: 'Gönder')
                    ],
                  ),
                ),
              ),
            ),
            child: const Text('Şifremi unuttum'),
          ),
        ),
        buildButton(onPressed: _submitLoginForm, text: 'Giriş Yap'),
        AppOrDivider(
          height: AppSizer.dividerH,
          tickness: AppSizer.dividerTicknessSmall,
        ),
        _buildLoginButtonsForAnotherPlatform,
      ],
    );
  }

  void _submitLoginForm() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      var result = await AuthService.instance
          .login(email: _loginModel.email!, password: _loginModel.password!);

      if (result == AuthStatus.successful) {
        context.router.replaceNamed(RoutePath.home.value);
      }
    }
  }

  void _submitForgotPasswordForm() async {
    if (_forgotPasswordformKey.currentState!.validate()) {
      _forgotPasswordformKey.currentState!.save();
      var result =
          await AuthService.instance.resetPassword(email: _loginModel.email!);

      if (result == AuthStatus.successful) {}
    }
  }

  Widget get _buildSignUpForm => Form(
      key: _loginFormKey,
      child: Column(
        children: [
          AppTextFormField(
            onSaved: (val) => _loginModel.email = val,
            hint: 'Email',
            keyboardType: TextInputType.emailAddress,
          ),
          AppSpacer.verticalSmallSpace,
          AppTextFormField(
            hint: 'Password',
            onSaved: (val) => _loginModel.password = val,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          AppSpacer.verticalSmallSpace,
        ],
      ));

  Widget get _buildLoginButtonsForAnotherPlatform => Column(
        children: [
          buildSignWithAnotherPlatform(context,
              icon: const Icon(
                FontAwesomeIcons.google,
              ),
              text: 'Google ile giriş yap'),
          AppSpacer.verticalSmallSpace,
          buildSignWithAnotherPlatform(context,
              color: Colors.white,
              textColor: Colors.black,
              icon: const Icon(
                FontAwesomeIcons.apple,
                color: Colors.black,
              ),
              text: 'Apple ile giriş yap'),
          AppSpacer.verticalSmallSpace,
          buildSignWithAnotherPlatform(
              color: Colors.indigo,
              icon: const Icon(FontAwesomeIcons.facebookF),
              context,
              text: 'Facebook ile giriş yap'),
        ],
      );
}
