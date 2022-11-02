import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:im_stepper/stepper.dart';

import '../../../../themes/project_themes.dart';
import '../../../../utils/const/app_padding.dart';
import '../../../../utils/const/app_sizer.dart';
import '../../../../utils/const/app_spacer.dart';
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
        _buildStep,
        AppSpacer.verticalSmallSpace,
        // _buildChooseUserType,
        _buildSignUpForm,
        buildButton(text: 'Kayıt Ol'),
        AppOrDivider(
          height: AppSizer.dividerH,
          tickness: AppSizer.dividerTicknessSmall,
        ),
        _buildLoginButtonsForAnotherPlatform,
      ],
    );
  }

  final ValueNotifier<int> _selectedUserType = ValueNotifier(0);

  Widget get _buildChooseUserType => ValueListenableBuilder(
        valueListenable: _selectedUserType,
        builder: (context, value, child) => Column(children: [
          InkWell(
            onTap: () => _selectedUserType.value = 0,
            child: Card(
              color: value != 0 ? null : colorLightGreen,
              child: Padding(
                padding: const EdgeInsets.all(10.0).r,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const FlutterLogo(
                          size: 50,
                        ),
                        Text(
                          'Tercüman',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: value != 0 ? colorHint : Colors.white),
                        )
                      ],
                    ),
                    if (value == 0)
                      Container(
                        height: AppSizer.cardMedium,
                      )
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () => _selectedUserType.value = 1,
            child: Card(
              color: value != 1 ? null : colorLightGreen,
              child: Padding(
                padding: AppPadding.layoutPadding,
                child: Row(
                  children: [
                    const FlutterLogo(
                      size: 50,
                    ),
                    Text(
                      'Kullanıcı',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: value != 1 ? colorHint : Colors.white),
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      );

  Widget get _buildSignUpForm => Form(
          child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: AppTextFormField(
                  hint: 'İsim',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              AppSpacer.horizontalSmallSpace,
              Expanded(
                child: AppTextFormField(
                  hint: 'Soy ismi',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
            ],
          ),
          AppSpacer.verticalSmallSpace,
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
              text: 'Google ile kayıt ol'),
          AppSpacer.verticalSmallSpace,
          buildLoginButtonForAnotherPlatform(context,
              color: Colors.white,
              textColor: Colors.black,
              icon: const Icon(
                FontAwesomeIcons.apple,
                color: Colors.black,
              ),
              text: 'Apple ile kayıt ol'),
          AppSpacer.verticalSmallSpace,
          buildLoginButtonForAnotherPlatform(
              color: Colors.indigo,
              icon: const Icon(FontAwesomeIcons.facebookF),
              context,
              text: 'Facebook ile kayıt ol'),
        ],
      );

  Widget get _buildStep => DotStepper(
        tappingEnabled: false,
        dotCount: 3,
        dotRadius: 8.r,
        shape: Shape.circle,
        spacing: 20.sp,
        indicator: Indicator.worm,
        indicatorDecoration: const IndicatorDecoration(color: colorLightGreen),
        activeStep: 0,
      );
}
