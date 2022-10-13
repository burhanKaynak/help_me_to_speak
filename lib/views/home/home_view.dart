import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/views/home/translator_list_view/translator_list_view.dart';

import '../../widgets/app_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Messages'),
      body: TranslatorListView(),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidComments), label: 'Sohbetler'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.users), label: 'Tercümanlar'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.download),
            label: 'Kayıtlı Çeviriler'),
      ]),
    );
  }
}
