import 'package:flutter/material.dart';

import '../core/const/app_padding.dart';
import '../core/const/app_radius.dart';
import '../core/const/app_sizer.dart';

class AppSearchBarField extends StatelessWidget {
  final String hint;
  AppSearchBarField({super.key, this.hint = 'Bir tecüman arayın'});

  final _textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: AppRadius.rectangleRadius,
        color: Colors.white,
      ),
      padding: AppPadding.inputPadding,
      child: TextField(
          cursorColor: const Color.fromARGB(31, 134, 134, 134),
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.black87),
          controller: _textController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.search_rounded,
              size: AppSizer.iconLarge,
            ),
            hintText: hint,
          )),
    );
  }
}
