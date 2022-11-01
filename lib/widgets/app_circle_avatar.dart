import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/project_themes.dart';

class AppCircleAvatar extends StatelessWidget {
  final String url;
  final double circleRadius;
  final double avatarWidth;
  final double avatarHeight;
  final double iconSize;

  const AppCircleAvatar({
    super.key,
    required this.url,
    this.avatarHeight = 100,
    this.avatarWidth = 100,
    this.iconSize = 15,
    this.circleRadius = 50,
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
            maxRadius: circleRadius,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: url,
                  width: avatarWidth,
                  height: avatarHeight,
                  fit: BoxFit.fitHeight,
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
  final List<String> langs;
  final bool showLangs;
  final bool showAddRemoveButton;
  final bool hasChat;
  final double circleRadius;
  final double avatarWidth;
  final double avatarHeight;
  final double iconSize;

  const AppListCircleAvatar(
      {super.key,
      required this.url,
      this.showAddRemoveButton = false,
      this.avatarHeight = 100,
      this.avatarWidth = 100,
      this.iconSize = 15,
      this.circleRadius = 50,
      required this.isOnline,
      this.hasChat = false,
      required this.langs,
      this.showLangs = true});

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
              maxRadius: circleRadius,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: url,
                    width: avatarWidth,
                    height: avatarHeight,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            ),
            if (showAddRemoveButton)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: hasChat ? colorPrimary : colorLightGreen,
                    ),
                    alignment: Alignment.center,
                    width: 25,
                    height: 25,
                    child: hasChat
                        ? const FaIcon(
                            FontAwesomeIcons.minus,
                            color: Colors.white,
                            size: 15,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                            size: 15,
                          )),
              ),
          ]),
        ),
        if (showLangs)
          const SizedBox(
            height: 15,
          ),
        if (showLangs)
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildLangIcons)
      ],
    );
  }

  List<Widget> get _buildLangIcons {
    var widgetCollection = <Widget>[];

    for (var item in langs) {
      widgetCollection.add(
        FaIcon(
          FontAwesomeIcons.globe,
          size: iconSize,
        ),
      );
      widgetCollection.add(
        const SizedBox(
          width: 10,
        ),
      );
    }

    return widgetCollection;
  }
}
