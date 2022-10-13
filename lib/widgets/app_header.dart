import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../themes/project_themes.dart';

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
        padding: EdgeInsets.only(top: padding * 1.5, right: 20, left: 20),
        child: _buildHeader(title: widget.title));
  }

  Widget _buildHeader({required String title}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (widget.backButton) const FaIcon(FontAwesomeIcons.chevronLeft),
              if (widget.backButton)
                const SizedBox(
                  width: 10,
                ),
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
              borderRadius: BorderRadius.circular(50),
              color: colorLightGreen,
            ),
            alignment: Alignment.center,
            width: 25,
            height: 25,
            child: const Text('1'),
          ),
          const SizedBox(
            width: 10,
          ),
          const FaIcon(FontAwesomeIcons.bars)
        ],
      );
}
