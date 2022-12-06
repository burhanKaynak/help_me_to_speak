import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/core/service/auth_service.dart';
import 'package:help_me_to_speak/core/service/database_service.dart';

import '../core/const/app_padding.dart';
import '../core/const/app_radius.dart';
import '../core/const/app_sizer.dart';
import '../core/const/app_spacer.dart';
import '../themes/project_themes.dart';

class AppCircleAvatar extends StatelessWidget {
  final String url;

  const AppCircleAvatar({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 5),
                  blurRadius: 5,
                  color: colorLightGreen.withAlpha(50),
                  blurStyle: BlurStyle.normal,
                  spreadRadius: 1)
            ],
          ),
          child: CircleAvatar(
            backgroundColor: colorLightGreen,
            maxRadius: AppSizer.avatarSmall,
            child: Padding(
              padding: AppPadding.avatarPadding,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: url,
                  width: AppSizer.imageLargeW,
                  height: AppSizer.imageLargeH,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AppListCircleAvatar extends StatelessWidget {
  final String url;
  final bool isOnline;
  final String? translatorId;
  final Widget? langs;
  final bool showLangs;
  final bool showAddRemoveButton;
  final bool hasChat;

  const AppListCircleAvatar(
      {super.key,
      required this.url,
      this.showAddRemoveButton = false,
      required this.isOnline,
      this.hasChat = false,
      this.langs,
      this.showLangs = true,
      this.translatorId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(2, 5),
                  blurRadius: 5,
                  color:
                      isOnline ? colorLightGreen.withAlpha(50) : Colors.black38,
                  blurStyle: BlurStyle.normal,
                  spreadRadius: 1)
            ],
          ),
          child: Stack(children: [
            CircleAvatar(
              backgroundColor: isOnline ? colorLightGreen : Colors.white,
              maxRadius: AppSizer.avatarSmall,
              child: Padding(
                padding: AppPadding.avatarPadding,
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: url,
                    width: AppSizer.imageLargeW,
                    height: AppSizer.imageLargeH,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            if (showAddRemoveButton && translatorId != null)
              Positioned(
                bottom: 0,
                right: 0,
                child: _streamBuilder(translatorId),
              ),
          ]),
        ),
        if (showLangs) AppSpacer.verticalLargeSpace,
        if (showLangs) langs ?? const SizedBox.shrink()
      ],
    );
  }

  StreamBuilder _streamBuilder(translatorId) => StreamBuilder(
        stream: DatabaseService.instance.getHasConversation(translatorId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return addOrRemoveButton(snapshot.data.docs.length > 0);
          }
          return const SizedBox.shrink();
        },
      );

  Widget addOrRemoveButton(hasConversation) => InkWell(
        onTap: () {
          if (hasConversation) {
            DatabaseService.instance.deleteConversation(
                AuthService.instance.currentUser!.uid, translatorId);
          } else {
            DatabaseService.instance.createConversation(
                AuthService.instance.currentUser!.uid, translatorId);
          }
        },
        child: Container(
            decoration: BoxDecoration(
              borderRadius: AppRadius.circleRadius,
              color: hasConversation ? colorPrimary : colorLightGreen,
            ),
            alignment: Alignment.center,
            width: AppSizer.circleSmall,
            height: AppSizer.circleSmall,
            child: hasConversation
                ? FaIcon(
                    FontAwesomeIcons.minus,
                    color: Colors.white,
                    size: AppSizer.iconSmall,
                  )
                : FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: AppSizer.iconSmall,
                  )),
      );
}
