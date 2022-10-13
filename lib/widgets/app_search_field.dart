import 'package:flutter/material.dart';

class AppSearchBarField extends StatelessWidget {
  final String hint;
  AppSearchBarField({super.key, this.hint = 'Bir tecüman arayın'});

  final _textController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(5),
      child: TextField(
          cursorColor: const Color.fromARGB(31, 134, 134, 134),
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.black87),
          controller: _textController,
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.search_rounded,
              size: 35,
            ),
            hintText: hint,
          )),
    );
  }
}
