import 'package:flutter/material.dart';

import '../themes/project_themes.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          const Expanded(
            child: Divider(
              height: 0.5,
              thickness: 1.5,
              color: colorHint,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Text('Veya',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: colorHint)),
          ),
          const Expanded(
            child: Divider(
              height: 0.5,
              thickness: 1.5,
              color: colorHint,
            ),
          ),
        ],
      ),
    );
  }
}
