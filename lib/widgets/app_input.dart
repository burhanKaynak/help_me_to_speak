import 'package:flutter/material.dart';

import '../core/const/app_padding.dart';
import '../core/const/app_radius.dart';

class AppTextFormField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final Function(String?)? onSaved;
  final TextInputType keyboardType;
  AppTextFormField({
    super.key,
    this.hint = '',
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onSaved,
  });

  final _textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: AppRadius.rectangleRadius,
          color: Colors.white,
        ),
        padding: AppPadding.horizontalPaddingMedium,
        child: TextFormField(
          autocorrect: true,
          onSaved: onSaved,
          keyboardType: keyboardType,
          cursorColor: const Color.fromARGB(31, 134, 134, 134),
          obscureText: obscureText,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.black87),
          controller: _textController,
          decoration: InputDecoration(hintText: hint),
        ));
  }
}
