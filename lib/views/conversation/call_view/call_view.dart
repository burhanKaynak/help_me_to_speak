import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/themes/project_themes.dart';
import 'package:help_me_to_speak/widgets/app_circle_avatar.dart';

class CallView extends StatefulWidget {
  const CallView({super.key});

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).padding.top * 2;
    return Scaffold(
      backgroundColor: colorDarkGreen,
      body: Padding(
        padding:
            EdgeInsets.only(top: paddingTop, left: 20, right: 20, bottom: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_buildHeader, _buildBody, _buildFooter],
        ),
      ),
    );
  }

  Widget get _buildHeader => Column(
        children: [
          const AppListCircleAvatar(
              url:
                  'https://img.freepik.com/free-photo/modern-woman-taking-selfie_23-2147893976.jpg?w=1380&t=st=1664901155~exp=1664901755~hmac=9127862f43915452a82d24ac02ba9768ff5b63354f3f46bcaf54bbf830d34235',
              isOnline: true,
              langs: [
                'asdasd',
                'asdasd',
              ]),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Angelina',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Şu an Konuşmada',
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      );
  Widget get _buildBody => Column(
        children: [
          Text(
            'Geçen Süre:',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            '1 Dakika 30 Saniye',
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Toplam Ücret:',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text(
            '15 KR',
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      );
  Widget get _buildFooter => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            alignment: Alignment.center,
            width: 75,
            height: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100), color: colorPrimary),
            child: FaIcon(
              FontAwesomeIcons.xmark,
              color: Colors.white,
              size: 35,
            ),
          ),
          Container(
            alignment: Alignment.center,
            width: 75,
            height: 75,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: colorLightGreen),
            child: FaIcon(
              FontAwesomeIcons.volumeHigh,
              color: Colors.white,
              size: 35,
            ),
          )
        ],
      );
}
