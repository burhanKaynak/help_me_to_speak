import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/themes/project_themes.dart';
import 'package:help_me_to_speak/widgets/app_buttons.dart';
import 'package:help_me_to_speak/widgets/app_circle_avatar.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          15.verticalSpace,
          _buildAvatar(context),
          15.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.globe,
                size: 20.r,
              ),
              10.horizontalSpace,
              FaIcon(
                FontAwesomeIcons.globe,
                size: 20.r,
              ),
            ],
          ),
          15.verticalSpace,
          _buildIdentification(context),
          15.verticalSpace,
          buildButton(
              text: 'Şifre Değiştir', prefix: FaIcon(FontAwesomeIcons.key)),
          buildButton(
              text: 'Çıkış Yap',
              prefix: FaIcon(FontAwesomeIcons.rightToBracket)),
          buildButton(
              text: 'Yardım', prefix: FaIcon(FontAwesomeIcons.circleInfo)),
          buildButton(
              text: 'Destek Dil Değiştir ',
              prefix: FaIcon(FontAwesomeIcons.globe))
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) => Stack(
        children: [
          AppCircleAvatar(
            url:
                'https://img.freepik.com/free-photo/modern-woman-taking-selfie_23-2147893976.jpg?w=1380&t=st=1664901155~exp=1664901755~hmac=9127862f43915452a82d24ac02ba9768ff5b63354f3f46bcaf54bbf830d34235',
          ),
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                alignment: Alignment.center,
                width: 25.w,
                height: 25.w,
                decoration: BoxDecoration(
                    color: colorDarkGreen,
                    borderRadius: BorderRadius.circular(100)),
                child: FaIcon(
                  FontAwesomeIcons.pencil,
                  size: 15.r,
                ),
              )),
        ],
      );

  Widget _buildIdentification(BuildContext context) => RichText(
      textAlign: TextAlign.center,
      text: TextSpan(children: [
        TextSpan(
          text: 'Angelina Blablabla\n',
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
