import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/core/enum/app_route_path_enum.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';
import 'package:help_me_to_speak/core/service/database_service.dart';
import 'package:help_me_to_speak/widgets/app_circle_image.dart';
import 'package:help_me_to_speak/widgets/app_shimmer.dart';

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
  final String _defAvatar =
      'https://www.ktoeos.org/wp-content/uploads/2021/11/default-avatar.png';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.layoutPadding,
      child: Column(
        children: [
          AppSpacer.verticalMediumSpace,
          _buildAvatar(context),
          AppSpacer.verticalMediumSpace,
          if (!_authService.getCustomer!.isApproved!)
            Wrap(
              spacing: 10,
              children: [
                const FaIcon(FontAwesomeIcons.clock),
                Text(
                  'Doğrulama için bekliyor.',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.black54),
                )
              ],
            ),
          if (_authService.getCustomer!.isApproved!)
            FutureBuilder(
              future: DatabaseService.instance
                  .getTranslatorSupporLanguages(_authService.currentUser!.uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Wrap(
                    spacing: 5,
                    children: snapshot.data!
                        .map((e) => AppCircleImage(image: e.thumbnail!))
                        .toList(),
                  );
                }
                return buildCircleShimmer;
              },
            ),
          AppSpacer.verticalMediumSpace,
          _buildIdentification(context),
          AppSpacer.verticalMediumSpace,
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
          AppCircleAvatar(
              url: _authService.currentUser?.photoURL ?? _defAvatar),
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
          text: _authService.getCustomer?.type == 1 ? 'Translator' : 'Customer',
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.black54,
              ),
        )
      ]));
}
