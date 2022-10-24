import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        padding: const EdgeInsets.all(20.0).r,
        child: Form(
            child: Column(
          children: [
            AppTextFormField(
              hint: 'Mevcut Şifre *',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            30.verticalSpace,
            AppTextFormField(
              hint: 'Şifre *',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            20.verticalSpace,
            AppTextFormField(
              hint: 'Şifre tekrar *',
              obscureText: true,
              keyboardType: TextInputType.visiblePassword,
            ),
            20.verticalSpace,
            buildButton(text: 'Kaydet')
          ],
        )),
      ),
    );
  }
}
