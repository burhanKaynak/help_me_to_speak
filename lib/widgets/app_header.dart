import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/project_themes.dart';
import '../utils/const/app_padding.dart';
import '../utils/const/app_radius.dart';
import '../utils/const/app_sizer.dart';
import '../utils/const/app_spacer.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final bool backButton;
  final String title;
  final Widget rightChild;

  const AppHeader(
      {super.key,
      this.backButton = false,
      required this.title,
      this.rightChild = const SizedBox.shrink()});

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize => const Size(0, 80);
}

class _AppHeaderState extends State<AppHeader> {
  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding.top;

    return Container(
        height: (kIsWeb || Platform.isWindows) ? 60 : null,
        padding: AppPadding.layoutPadding.copyWith(top: padding * 1.5),
        child: _buildHeader(title: widget.title));
  }

  Widget _buildHeader({required String title}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (widget.backButton) const FaIcon(FontAwesomeIcons.chevronLeft),
              if (widget.backButton) AppSpacer.horizontalSmallSpace,
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: colorDarkGreen),
              ),
            ],
          ),
          widget.rightChild
        ],
      );

  Widget get _defRightChild => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: AppRadius.rectangleRadius,
              color: colorLightGreen,
            ),
            alignment: Alignment.center,
            width: AppSizer.circleSmall,
            height: AppSizer.circleSmall,
            child: const Text('1'),
          ),
          AppSpacer.horizontalSmallSpace,
          const FaIcon(FontAwesomeIcons.bars)
        ],
      );
}
