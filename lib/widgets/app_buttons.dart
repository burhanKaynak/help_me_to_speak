import 'package:flutter/material.dart';

Widget buildButton({required String text, Widget? sufix, Widget? prefix}) {
  return ElevatedButton(
      onPressed: null,
      child: Row(
        children: [
          prefix ?? const SizedBox.shrink(),
          Expanded(
              child: Align(alignment: Alignment.center, child: Text(text))),
          sufix ?? const SizedBox.shrink()
        ],
      ));
}

Widget buildLoginButtonForAnotherPlatform(BuildContext context,
    {required String text, Widget? icon, Color? color, Color? textColor}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
      ),
      onPressed: () => null,
      child: Row(
        children: [
          icon ?? const SizedBox.shrink(),
          Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .button!
                        .copyWith(color: textColor),
                  ))),
        ],
      ));
}
