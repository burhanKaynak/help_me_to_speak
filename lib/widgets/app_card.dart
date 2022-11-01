import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/views/home/chat_list_view/chat_list_view.dart';

import '../themes/project_themes.dart';
import 'app_circle_avatar.dart';

//ignore: must_be_immutable
class AppCard extends StatelessWidget {
  final Chat chat;
  final bool topDivider;
  AppCard({super.key, required this.chat, this.topDivider = true});

  double? _cardHeight;
  ThemeData? _themeData;
  @override
  Widget build(BuildContext context) {
    _cardHeight = 145;
    _themeData = Theme.of(context);

    return Container(
      color: _themeData!.scaffoldBackgroundColor,
      child: Column(
        children: [
          if (topDivider)
            const Divider(
              height: 0.5,
              thickness: 1.5,
              color: Colors.white,
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCardLeftSide,
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: _buildCardMiddle,
                ),
                _buildCardRightSide
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget get _buildCardLeftSide {
    return SizedBox(
      height: _cardHeight,
      child: AppListCircleAvatar(
        url: chat.avatar,
        isOnline: chat.isOnline,
        langs: const [
          'sdas',
          'asdas',
        ],
      ),
    );
  }

  Widget get _buildCardMiddle => SizedBox(
        height: _cardHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      chat.fullName,
                      style: _themeData!.textTheme.headline5!
                          .copyWith(color: colorDarkGreen),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: colorLightGreen,
                      ),
                      alignment: Alignment.center,
                      width: 25,
                      height: 25,
                      child: const Text('1'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(chat.isOnline ? 'Şu an Çeviriye Hazır' : 'Çevirimdışı',
                    style: _themeData!.textTheme.bodyText1!.copyWith(
                        color: chat.isOnline ? colorLightGreen : colorHint)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Text(
                      chat.lastSeen,
                      style: _themeData!.textTheme.caption!
                          .copyWith(color: colorHint),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(chat.lastMessage,
                    overflow: TextOverflow.ellipsis,
                    style: _themeData!.textTheme.bodyText1!.copyWith(
                        color: Colors.black,
                        fontWeight: chat.isOnline
                            ? FontWeight.w700
                            : FontWeight.normal))
              ],
            )
          ],
        ),
      );

  Widget get _buildCardRightSide => SizedBox(
        height: _cardHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            IconButton(onPressed: null, icon: FaIcon(FontAwesomeIcons.phone)),
            IconButton(onPressed: null, icon: FaIcon(FontAwesomeIcons.video)),
            IconButton(
                onPressed: null, icon: FaIcon(FontAwesomeIcons.solidMessage)),
          ],
        ),
      );
}
