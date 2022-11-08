import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/core/enum/toast_type.dart';
import 'package:help_me_to_speak/themes/project_themes.dart';

import '../const/app_spacer.dart';
import '../router/app_router.gr.dart';

class Utils {
  static final appRouter = AppRouter();
  static void showCircleProgress() => showDialog(
        barrierDismissible: false,
        context: appRouter.navigatorKey.currentContext!,
        builder: (context) => WillPopScope(
            onWillPop: () => Future<bool>.value(false),
            child: const AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: Center(
                child: CircularProgressIndicator(),
              ),
            )),
      );

  static void showToast({required ToastType type, required String message}) {
    ScaffoldMessenger.of(appRouter.navigatorKey.currentContext!)
        .showSnackBar(SnackBar(
      content: Row(
        children: [
          FaIcon(
            type == ToastType.succes
                ? FontAwesomeIcons.check
                : type == ToastType.warning
                    ? FontAwesomeIcons.exclamation
                    : FontAwesomeIcons.xmark,
            color: type == ToastType.succes
                ? colorLightGreen
                : type == ToastType.warning
                    ? Colors.yellow
                    : Colors.redAccent,
          ),
          AppSpacer.horizontalSmallSpace,
          Text(
            message,
          ),
        ],
      ),
    ));
  }
}
