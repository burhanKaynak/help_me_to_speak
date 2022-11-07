import 'package:flutter/material.dart';

import '../router/app_router.gr.dart';

class Utils {
  static final appRouter = AppRouter();
  static void showCircleProgress() => {
        showDialog(
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
        )
      };
}
