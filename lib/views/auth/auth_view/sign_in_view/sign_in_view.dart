import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/const/app_padding.dart';
import '../../../../core/const/app_sizer.dart';
import '../../../../core/const/app_spacer.dart';
import '../../../../core/enum/app_route_path_enum.dart';
import '../../../../core/error/auth_exeption_handler.dart';
import '../../../../core/locale/locale_keys.g.dart';
import '../../../../core/models/request/login_model.dart';
import '../../../../core/service/auth_service.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/project_themes.dart';
import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_divider.dart';
import '../../../../widgets/app_input.dart';

class SingInView extends StatefulWidget {
  final VoidCallback onTapSignUp;
  const SingInView({super.key, required this.onTapSignUp});

  @override
  State<SingInView> createState() => _SingInViewState();
}

class _SingInViewState extends State<SingInView> {
  final _loginFormKey = GlobalKey<FormState>();
  final _forgotPasswordformKey = GlobalKey<FormState>();
  final _loginModel = LoginModel(email: '', password: '');
  final ValueNotifier<bool> _verifyNotifier = ValueNotifier(true);
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _verifyNotifier,
        builder: (context, value, child) =>
            value ? _buildStepSignIn : _buildStepVerify);
  }

  Widget get _buildStepSignIn => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          hint: LocaleKeys.email.tr(),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        AppSpacer.verticalMediumSpace,
                        buildButton(
                            onPressed: _submitForgotPasswordForm,
                            text: 'Gönder')
                      ],
                    ),
                  ),
                ),
              ),
              child: Text(LocaleKeys.forgot_password.tr()),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                buildButton(
                    onPressed: _submitLoginForm, text: LocaleKeys.sign_in.tr()),
                AppOrDivider(
                  height: AppSizer.dividerH,
                  tickness: AppSizer.dividerTicknessSmall,
                ),
                _buildLoginButtonsForAnotherPlatform,
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: widget.onTapSignUp,
                  child: Text(LocaleKeys.sign_up.tr())))
        ],
      );

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _submitLoginForm() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      Utils.showCircleProgress();
      var result = await AuthService.instance
          .login(email: _loginModel.email!, password: _loginModel.password!);

      context.router.navigatorKey.currentState!.pop();
      if (result == AuthStatus.successful) {
        if (AuthService.instance.currentUser!.emailVerified) {
          context.router.replaceNamed(RoutePath.home.value);
        } else {
          _verifyNotifier.value = false;
          _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
            var result = await AuthService.instance.checkEmailVerified();
            if (result) {
              _timer?.cancel();
              context.router.replaceNamed(RoutePath.home.value);
            }
          });
        }
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
            initialValue: _loginModel.email,
            onChanged: (val) => _loginModel.email = val,
            onSaved: (val) => _loginModel.email = val,
            hint: LocaleKeys.email.tr(),
            keyboardType: TextInputType.emailAddress,
          ),
          AppSpacer.verticalSmallSpace,
          AppTextFormField(
            initialValue: _loginModel.password,
            onChanged: (val) => _loginModel.password = val,
            hint: LocaleKeys.password.tr(),
            onSaved: (val) => _loginModel.password = val,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
          ),
          AppSpacer.verticalSmallSpace,
        ],
      ));
  Widget get _buildStepVerify => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'An email has been sent to ${AuthService.instance.currentUser!.email} please verify',
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.black87),
          ),
          AppSpacer.verticalMediumSpace,
          buildButton(
              onPressed: () async {
                Utils.showCircleProgress();
                var result = await AuthService.instance.sendMailVerification();
                context.router.navigatorKey.currentState!.pop();

                if (result == AuthStatus.successful) {}
              },
              text: ('Resend mail'),
              prefix: FaIcon(FontAwesomeIcons.envelope)),
          TextButton(
              onPressed: () async {
                await AuthService.instance.logout();
                _verifyNotifier.value = true;
                _timer?.cancel();
              },
              child: const Text('Cancel'))
        ],
      );

  Widget get _buildLoginButtonsForAnotherPlatform => Column(
        children: [
          buildSignWithAnotherPlatform(context,
              icon: const Icon(
                FontAwesomeIcons.google,
              ),
              text: LocaleKeys.sign_in_with_paltform
                  .tr(namedArgs: {'platform': 'Google'})),
          AppSpacer.verticalSmallSpace,
          buildSignWithAnotherPlatform(context,
              color: Colors.white,
              textColor: Colors.black,
              icon: const Icon(
                FontAwesomeIcons.apple,
                color: Colors.black,
              ),
              text: LocaleKeys.sign_in_with_paltform
                  .tr(namedArgs: {'platform': 'Apple'})),
          AppSpacer.verticalSmallSpace,
          buildSignWithAnotherPlatform(
              color: Colors.indigo,
              icon: const Icon(FontAwesomeIcons.facebookF),
              context,
              text: LocaleKeys.sign_in_with_paltform
                  .tr(namedArgs: {'platform': 'Facebook'})),
        ],
      );
}
