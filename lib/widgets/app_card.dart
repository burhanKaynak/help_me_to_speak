import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../core/const/app_common_const.dart';
import '../core/const/app_padding.dart';
import '../core/const/app_radius.dart';
import '../core/const/app_sizer.dart';
import '../core/const/app_spacer.dart';
import '../core/models/response/chat_model.dart';
import '../core/models/response/message_model.dart';
import '../core/service/auth_service.dart';
import '../themes/project_themes.dart';
import 'app_circle_avatar.dart';
import 'app_divider.dart';

//ignore: must_be_immutable
class AppCard extends StatelessWidget {
  final Chat chat;
  final bool topDivider;

  final VoidCallback? onTapVoiceCall, onTapVideoCall, onTapChat;

  AppCard({
    super.key,
    required this.chat,
    this.onTapVideoCall,
    this.onTapChat,
    this.onTapVoiceCall,
    this.topDivider = true,
  });

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
                  child: _streamBuilder,
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
        url: chat.customer.photoUrl ?? CommonConst.defAvatar,
        isOnline: true,
        langs: null,
      ),
    );
  }

  StreamBuilder get _streamBuilder => StreamBuilder(
      stream: chat.snapshot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var messages = List<Message>.from(
              snapshot.data.docs.map((e) => Message.fromJson(e.data())));
          messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));
          var count = messages
              .where((i) =>
                  !i.isSeens &&
                  i.senderId != AuthService.instance.currentUser!.uid)
              .length;
          return _buildCardMiddle(messages.first, count);
        }
        return const SizedBox.shrink();
      });

  Widget _buildCardMiddle(Message message, int unseensCount) {
    var formatDate = DateFormat('EEEE hh:mm').format(message.timestamp);
    return SizedBox(
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
                  Text(chat.customer.displayName!,
                      style: _themeData!.textTheme.headline5!.copyWith(
                          fontWeight: FontWeight.w500, color: colorDarkGreen)),
                  AppSpacer.horizontalLargeSpace,
                  if (unseensCount > 0)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: AppRadius.circleRadius,
                        color: colorLightGreen,
                      ),
                      alignment: Alignment.center,
                      width: AppSizer.circleSmall,
                      height: AppSizer.circleSmall,
                      child: Text(unseensCount.toString()),
                    ),
                ],
              ),
              AppSpacer.verticalSmallSpace,
              Text(true ? 'Çevirimiçi' : 'Çevirimdışı',
                  style: _themeData!.textTheme.bodyText1!
                      .copyWith(color: true ? colorLightGreen : colorHint)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    formatDate,
                    style: _themeData!.textTheme.caption!
                        .copyWith(color: colorHint),
                  ),
                  AppSpacer.horizontalMediumSpace,
                ],
              ),
              AppSpacer.verticalSmallSpace,
              Text(message.message,
                  overflow: TextOverflow.ellipsis,
                  style: _themeData!.textTheme.bodyText1!.copyWith(
                      color: Colors.black,
                      fontWeight: true ? FontWeight.w700 : FontWeight.normal))
            ],
          )
        ],
      ),
    );
  }

  Widget get _buildCardRightSide => SizedBox(
        height: AppSizer.cardLarge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed:
                    chat.customer.availableVoiceCall! ? onTapVoiceCall : null,
                icon: const FaIcon(FontAwesomeIcons.phone)),
            IconButton(
                onPressed:
                    chat.customer.availableVideoCall! ? onTapVideoCall : null,
                icon: const FaIcon(FontAwesomeIcons.video)),
            IconButton(
                onPressed: chat.customer.availableChat! ? onTapChat : null,
                icon: const FaIcon(FontAwesomeIcons.solidMessage)),
          ],
        ),
      );
}
