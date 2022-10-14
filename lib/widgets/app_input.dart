import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String hint;
  final bool obscureText;
  final TextInputType keyboardType;
  AppTextFormField(
      {super.key,
      this.hint = '',
      this.obscureText = false,
      this.keyboardType = TextInputType.text});

  final _textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
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
