import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/const/app_padding.dart';
import '../../../../core/const/app_sizer.dart';
import '../../../../core/const/app_spacer.dart';
import '../../../../core/enum/app_route_path_enum.dart';
import '../../../../core/enum/toast_type_enum.dart';
import '../../../../core/error/auth_exeption_handler.dart';
import '../../../../core/locale/locale_keys.g.dart';
import '../../../../core/models/request/register_model.dart';
import '../../../../core/service/auth_service.dart';
import '../../../../core/service/database_service.dart';
import '../../../../core/service/storage_service.dart';
import '../../../../core/utils/utils.dart';
import '../../../../themes/project_themes.dart';
import '../../../../widgets/app_buttons.dart';
import '../../../../widgets/app_divider.dart';
import '../../../../widgets/app_input.dart';

class SignUpView extends StatefulWidget {
  final VoidCallback onTapSignIn;

  const SignUpView({super.key, required this.onTapSignIn});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _registerModel = RegisterModel(email: '', fullName: '', password: '');
  final ValueNotifier<int> _signUpStepNotifier = ValueNotifier(0);
  final ValueNotifier<int> _selectedUserType = ValueNotifier(0);
  final ValueNotifier<List<XFile>> _selectedImages = ValueNotifier([]);
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _signUpStepNotifier,
      builder: (context, value, child) {
        if (value == 1) {
          _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
            var result = await AuthService.instance.checkEmailVerified();
            if (result) {
              _timer?.cancel();
              _signUpStepNotifier.value = 2;
            }
          });
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildStep,
            AppSpacer.verticalSmallSpace,
            if (value == 0) Expanded(child: _buildStepRegister),
            if (value == 1) Expanded(child: _buildStepVerify),
            if (value == 2) Expanded(child: _buildStepUserType)
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget get _buildStepRegister => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSignUpForm,
          Expanded(
              child: ListView(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildButton(
                  onPressed: _submitForm, text: LocaleKeys.sign_up.tr()),
              AppOrDivider(
                height: AppSizer.dividerH,
                tickness: AppSizer.dividerTicknessSmall,
              ),
              _buildLoginButtonsForAnotherPlatform,
            ],
          )),
          Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                  onPressed: widget.onTapSignIn,
                  child: Text(LocaleKeys.sign_in.tr())))
        ],
      );

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
                if (result == AuthStatus.successful) {}
                context.router.navigatorKey.currentState!.pop();
              },
              text: ('Resend mail'),
              prefix: FaIcon(FontAwesomeIcons.envelope)),
          TextButton(
              onPressed: () async {
                await AuthService.instance.logout();
                _timer?.cancel();
                _signUpStepNotifier.value = 0;
              },
              child: const Text('Cancel'))
        ],
      );

  Widget get _buildStepUserType => ValueListenableBuilder(
        valueListenable: _selectedUserType,
        builder: (context, value, child) => Column(children: [
          InkWell(
            onTap: () => _selectedUserType.value = 0,
            child: Card(
              color: value != 0 ? null : colorLightGreen,
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
                          color: value != 0 ? colorHint : Colors.white),
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
                                  color: value != 1 ? colorHint : Colors.white),
                        )
                      ],
                    ),
                    if (value == 1)
                      SizedBox(
                        height: AppSizer.cardMedium,
                        child: Column(
                          children: [
                            Expanded(
                              child: ValueListenableBuilder(
                                valueListenable: _selectedImages,
                                builder: (context, value, child) =>
                                    ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: value.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: AppPadding.horizontalPaddingSmall,
                                    child: Image.file(File(value[index].path)),
                                  ),
                                ),
                              ),
                            ),
                            buildButton(
                                onPressed: _pickImageFromGallery,
                                text: 'Resim Seç')
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
          buildButton(onPressed: _submitUserType, text: 'Devam Et')
        ]),
      );

  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImageFromGallery() async {
    _selectedImages.value = await _picker.pickMultiImage();
  }

  Widget get _buildSignUpForm => Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextFormField(
            initialValue: _registerModel.fullName,
            onChanged: (val) => _registerModel.fullName = val,
            hint: LocaleKeys.full_name.tr(),
            keyboardType: TextInputType.emailAddress,
            onSaved: (val) => _registerModel.fullName = val,
          ),
          AppSpacer.verticalSmallSpace,
          AppTextFormField(
            initialValue: _registerModel.email,
            onChanged: (val) => _registerModel.email = val,
            hint: LocaleKeys.email.tr(),
            keyboardType: TextInputType.emailAddress,
            onSaved: (val) => _registerModel.email = val,
          ),
          AppSpacer.verticalSmallSpace,
          AppTextFormField(
            initialValue: _registerModel.password,
            onChanged: (val) => _registerModel.password = val,
            hint: LocaleKeys.password.tr(),
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            onSaved: (val) => _registerModel.password = val,
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
              text: LocaleKeys.sign_up_with_paltform
                  .tr(namedArgs: {'platform': 'Google'})),
          AppSpacer.verticalSmallSpace,
          buildSignWithAnotherPlatform(context,
              color: Colors.white,
              textColor: Colors.black,
              icon: const Icon(
                FontAwesomeIcons.apple,
                color: Colors.black,
              ),
              text: LocaleKeys.sign_up_with_paltform
                  .tr(namedArgs: {'platform': 'Apple'})),
          AppSpacer.verticalSmallSpace,
          buildSignWithAnotherPlatform(
              color: Colors.indigo,
              icon: const Icon(FontAwesomeIcons.facebookF),
              context,
              text: LocaleKeys.sign_up_with_paltform
                  .tr(namedArgs: {'platform': 'Facebook'})),
        ],
      );

  void _submitUserType() async {
    Utils.showCircleProgress();

    if (_selectedUserType.value == 1) {
      if (_selectedImages.value.isEmpty) {
        context.router.navigatorKey.currentState!.pop();
        Utils.showToast(
            type: ToastType.warning, message: 'Döküman yüklemeniz gerekiyor.');
        return;
      }
      var savedPaths = <String>[];
      for (var i = 0; i < _selectedImages.value.length; i++) {
        final file = File(_selectedImages.value[i].path);
        var result =
            await StorageService.instance.putFileUserDocuments(file, i);
        savedPaths.add(result);
      }

      await DatabaseService.instance.setTranslatorDocuments(savedPaths);
    }
    var result =
        await DatabaseService.instance.updateUserType(_selectedUserType.value);
    context.router.navigatorKey.currentState!.pop();
    if (result) {
      context.router.replaceNamed(RoutePath.home.value);
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Utils.showCircleProgress();
      var result = await AuthService.instance.createAccount(
          email: _registerModel.email!,
          password: _registerModel.password!,
          name: _registerModel.fullName!);
      if (result == AuthStatus.successful) {
        await DatabaseService.instance
            .register(user: AuthService.instance.currentUser!);
        AuthService.instance.sendMailVerification();
        _signUpStepNotifier.value = 1;
      }
      context.router.navigatorKey.currentState!.pop();
    }
  }

  Widget get _buildStep => DotStepper(
        tappingEnabled: false,
        dotCount: 3,
        dotRadius: 8.r,
        shape: Shape.circle,
        spacing: 20.sp,
        indicator: Indicator.worm,
        indicatorDecoration: const IndicatorDecoration(color: colorLightGreen),
        activeStep: _signUpStepNotifier.value,
      );
}
