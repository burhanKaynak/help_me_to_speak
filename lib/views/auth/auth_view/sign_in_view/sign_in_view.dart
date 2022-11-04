import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/core/models/request/login_model.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _loginModel = LoginModel();

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
        buildButton(onPressed: _submitForm, text: 'Giriş Yap'),
        AppOrDivider(
          height: AppSizer.dividerH,
          tickness: AppSizer.dividerTicknessSmall,
        ),
        _buildLoginButtonsForAnotherPlatform,
      ],
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _loginModel.email!, password: _loginModel.password!);

        FirebaseAuth.instance.authStateChanges().listen((event) {
          if (credential.user != null) {
            context.router.replaceNamed('/home');
          } else {
            throw FirebaseAuthException(code: '1001', message: 'Bla Bla');
          }
        });
      } on FirebaseAuthException catch (e) {
        print(e.message);
      }
    }
  }

  Widget get _buildSignUpForm => Form(
      key: _formKey,
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
