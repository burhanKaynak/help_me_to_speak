import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/const/app_padding.dart';
import '../core/const/app_spacer.dart';
import 'app_divider.dart';

enum SheetHeight {
  high(0.965),
  medium(0.7),
  low(0.5);

  final double value;
  const SheetHeight(this.value);
}

//
bool _keyboardVisible = true;
Future<dynamic> appShowModalBottomSheet(BuildContext context,
    {Widget? child, SheetHeight? sheetHeight, bool isDismissible = false}) {
  return showModalBottomSheet(
      useRootNavigator: true,
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        var scHeight = ScreenUtil().screenHeight;
        var scWidth = ScreenUtil().screenWidth;
        var bottomPaddig = MediaQuery.of(context).viewInsets.bottom;
        _keyboardVisible = bottomPaddig == 0;
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: scHeight * 0.965),
          child: Padding(
            padding: EdgeInsets.only(bottom: bottomPaddig),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              height: scHeight *
                      (sheetHeight != null
                          ? sheetHeight.value
                          : SheetHeight.high.value) +
                  bottomPaddig,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: AppPadding.layoutPadding,
                      child: Column(
                        children: [
                          Container(
                            height: scHeight * 0.015,
                            width: scWidth * 0.2,
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius: BorderRadius.circular(50)),
                          ),
                          AppSpacer.verticalMediumSpace,
                          Expanded(
                              child: SingleChildScrollView(
                                  child: child ?? const SizedBox.shrink())),
                        ],
                      ),
                    ),
                  ),
                  if (!_keyboardVisible) _buildKeyboardFooter(context)
                ],
              ),
            ),
          ),
        );
      });
}

Widget _buildKeyboardFooter(BuildContext context) => SizedBox(
    height: ScreenUtil().setHeight(40),
    child: Stack(
      children: [
        InkWell(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const AppDivider(
                  height: 1,
                  tickness: 2,
                  color: Colors.black38,
                ),
                Padding(
                  padding: AppPadding.cardPadding,
                  child: Text(
                    'Tamam',
                    style: Theme.of(context).textTheme.button!.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
