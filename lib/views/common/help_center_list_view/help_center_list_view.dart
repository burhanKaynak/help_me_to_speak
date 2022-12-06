import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:help_me_to_speak/widgets/app_header.dart';

class HelpCenterListView extends StatelessWidget {
  const HelpCenterListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: 'Help Center',
        backButton: true,
      ),
    );
  }
}
