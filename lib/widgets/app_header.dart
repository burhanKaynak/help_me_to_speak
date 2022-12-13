import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/const/app_padding.dart';
import '../core/const/app_radius.dart';
import '../core/const/app_sizer.dart';
import '../core/const/app_spacer.dart';
import '../themes/project_themes.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final VoidCallback? onTapTitle;
  final bool backButton;
  final String title;
  final Widget rightChild;

  const AppHeader(
      {super.key,
      this.backButton = false,
      required this.title,
      this.rightChild = const SizedBox.shrink(),
      this.onTapTitle});

  @override
  State<AppHeader> createState() => AppHeaderState();

  @override
  Size get preferredSize => const Size(0, 80);
}

class AppHeaderState extends State<AppHeader> {
  late final ValueNotifier<String> _titleNotifier = ValueNotifier(widget.title);

  @override
  void initState() {
    _titleNotifier.value = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding.top;

    return Container(
        height: (kIsWeb || Platform.isWindows) ? 60 : null,
        padding: AppPadding.layoutPadding.copyWith(top: padding * 1.5),
        child: _buildHeader(title: widget.title));
  }

  void setHeaderTitle(String title) {
    _titleNotifier.value = title;
  }

  Widget _buildHeader({required String title}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (widget.backButton)
                InkWell(
                    onTap: () => context.router.pop(),
                    child: const FaIcon(FontAwesomeIcons.chevronLeft)),
              if (widget.backButton) AppSpacer.horizontalSmallSpace,
              ValueListenableBuilder(
                  valueListenable: _titleNotifier,
                  builder: (context, value, child) => AnimatedSwitcher(
                        transitionBuilder:
                            (widget, Animation<double> animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: widget,
                          );
                        },
                        duration: const Duration(milliseconds: 400),
                        child: InkWell(
                          onTap: widget.onTapTitle,
                          child: Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: colorDarkGreen),
                            key: ValueKey<String>(value),
                          ),
                        ),
                      ))
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
