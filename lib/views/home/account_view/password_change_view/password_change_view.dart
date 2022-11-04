import 'package:flutter/material.dart';

import '../../../../core/const/app_padding.dart';
import '../../../../core/const/app_spacer.dart';
import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_header.dart';
import '../../../../widgets/app_input.dart';

class PasswordChangeView extends StatelessWidget {
  const PasswordChangeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(backButton: true, title: 'Şifre Değiştir'),
      body: Padding(
        padding: AppPadding.layoutPadding,
        child: Form(
            child: Column(
          children: [
            AppTextFormField(
              hint: 'Mevcut Şifre *',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            AppSpacer.verticalLargeSpace,
            AppTextFormField(
              hint: 'Şifre *',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            AppSpacer.verticalMediumSpace,
            AppTextFormField(
              hint: 'Şifre tekrar *',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            AppSpacer.verticalMediumSpace,
            buildButton(onPressed: null, text: 'Kaydet')
          ],
        )),
      ),
    );
  }
}
