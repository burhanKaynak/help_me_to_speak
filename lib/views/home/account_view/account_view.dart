import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/core/enum/app_route_path_enum.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';

import '../../../core/const/app_padding.dart';
import '../../../core/const/app_radius.dart';
import '../../../core/const/app_sizer.dart';
import '../../../core/const/app_spacer.dart';
import '../../../themes/project_themes.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_circle_avatar.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final AuthService _authService = AuthService.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.layoutPadding,
      child: Column(
        children: [
          AppSpacer.verticalMediumSpace,
          _buildAvatar(context),
          AppSpacer.verticalMediumSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.globe,
                size: AppSizer.iconSmall,
              ),
              AppSpacer.horizontalSmallSpace,
              FaIcon(
                FontAwesomeIcons.globe,
                size: AppSizer.iconSmall,
              ),
            ],
          ),
          15.verticalSpace,
          _buildIdentification(context),
          15.verticalSpace,
          buildButton(
              onPressed: null,
              text: 'Şifre Değiştir',
              prefix: const FaIcon(FontAwesomeIcons.key)),
          buildButton(
              onPressed: null,
              text: 'Yardım',
              prefix: const FaIcon(FontAwesomeIcons.circleInfo)),
          buildButton(
              onPressed: null,
              text: 'Destek Dil Değiştir ',
              prefix: const FaIcon(FontAwesomeIcons.globe)),
          buildButton(
              onPressed: () async => await _authService.logout().then(
                  (value) => context.router.replaceNamed(RoutePath.auth.value)),
              text: 'Çıkış Yap',
              prefix: const FaIcon(FontAwesomeIcons.rightToBracket))
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) => Stack(
        children: [
          const AppCircleAvatar(
            url:
                'https://img.freepik.com/free-photo/modern-woman-taking-selfie_23-2147893976.jpg?w=1380&t=st=1664901155~exp=1664901755~hmac=9127862f43915452a82d24ac02ba9768ff5b63354f3f46bcaf54bbf830d34235',
          ),
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                width: AppSizer.circleMedium,
                height: AppSizer.circleMedium,
                decoration: BoxDecoration(
                    color: colorDarkGreen,
                    borderRadius: AppRadius.circleRadius),
                child: FaIcon(
                  FontAwesomeIcons.pencil,
                  size: AppSizer.iconSmall,
                ),
              )),
        ],
      );

  Widget _buildIdentification(BuildContext context) => RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: '${_authService.currentUser!.displayName}\n',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.black),
        ),
        TextSpan(
          text: 'Translator',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black54,
              ),
        )
      ]));
}
