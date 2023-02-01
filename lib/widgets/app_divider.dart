import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../core/const/app_padding.dart';
import '../core/const/app_sizer.dart';
import '../core/locale/locale_keys.g.dart';
import '../themes/project_themes.dart';

class AppOrDivider extends StatelessWidget {
  final double height;
  final double tickness;
  const AppOrDivider({super.key, required this.height, required this.tickness});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPadding.verticalPaddingSmall,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              height: AppSizer.dividerH,
              thickness: AppSizer.dividerTicknessSmall,
              color: colorHint,
            ),
          ),
          Container(
            margin: AppPadding.horizontalPaddingMedium,
            child: Text(LocaleKeys.or.tr(),
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: colorHint)),
          ),
          Expanded(
            child: Divider(
              height: height,
              thickness: tickness,
              color: colorHint,
            ),
          ),
        ],
      ),
    );
  }
}

class AppDivider extends StatelessWidget {
  final double height;
  final double tickness;
  final Color? color;
  const AppDivider(
      {super.key, required this.height, required this.tickness, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: tickness,
      color: color ?? Colors.white,
    );
  }
}
