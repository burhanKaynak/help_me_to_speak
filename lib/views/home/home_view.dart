import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/app_header.dart';
import 'account_view/account_view.dart';

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
      body: const AccountView(),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.solidComments), label: 'Sohbetler'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.users), label: 'Tercümanlar'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.download),
            label: 'Kayıtlı Çeviriler'),
        BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.gear), label: 'Ayarlar'),
      ]),
    );
  }
}
