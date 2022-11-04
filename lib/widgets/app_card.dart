import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/const/app_padding.dart';
import '../core/const/app_radius.dart';
import '../core/const/app_sizer.dart';
import '../core/const/app_spacer.dart';
import '../themes/project_themes.dart';
import '../views/home/chat_list_view/chat_list_view.dart';
import 'app_circle_avatar.dart';
import 'app_divider.dart';

//ignore: must_be_immutable
class AppCard extends StatelessWidget {
  final Chat chat;
  final bool topDivider;
  AppCard({super.key, required this.chat, this.topDivider = true});

  ThemeData? _themeData;
  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return Container(
      color: _themeData!.scaffoldBackgroundColor,
      child: Column(
        children: [
          if (topDivider)
            AppDivider(
              height: AppSizer.dividerH,
              tickness: AppSizer.dividerTicknessSmall,
            ),
          Padding(
            padding: AppPadding.layoutPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCardLeftSide,
                AppSpacer.horizontalLargeSpace,
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
      height: AppSizer.cardLarge,
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
        height: AppSizer.cardLarge,
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
                    AppSpacer.horizontalLargeSpace,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: AppRadius.circleRadius,
                        color: colorLightGreen,
                      ),
                      alignment: Alignment.center,
                      width: AppSizer.circleSmall,
                      height: AppSizer.circleSmall,
                      child: const Text('1'),
                    ),
                  ],
                ),
                AppSpacer.verticalSmallSpace,
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
                    AppSpacer.horizontalMediumSpace,
                  ],
                ),
                AppSpacer.verticalSmallSpace,
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
        height: AppSizer.cardLarge,
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
