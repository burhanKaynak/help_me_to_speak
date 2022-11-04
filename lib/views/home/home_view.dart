import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/views/home/account_view/account_view.dart';
import 'package:help_me_to_speak/views/home/chat_list_view/chat_list_view.dart';
import 'package:help_me_to_speak/views/home/translator_list_view/translator_list_view.dart';

import '../../widgets/app_header.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ValueNotifier<int> _tabNotifier = ValueNotifier(0);
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: false, viewportFraction: 1);
  final GlobalKey<AppHeaderState> _headerKey = GlobalKey<AppHeaderState>();

  final _tabPages = <Widget>[
    const ChatListView(),
    const TranslatorListView(),
    const AccountView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(key: _headerKey, title: 'Messages'),
      body: PageView.builder(
          itemCount: 3,
          physics: const NeverScrollableScrollPhysics(),
          pageSnapping: true,
          controller: _pageController,
          itemBuilder: (context, index) => _tabPages[index]),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _tabNotifier,
        builder: (context, value, child) => BottomNavigationBar(
            currentIndex: value,
            onTap: _tabPage,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidComments),
                  label: 'Sohbetler'),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.users), label: 'Tercümanlar'),
              // BottomNavigationBarItem(
              //     icon: FaIcon(FontAwesomeIcons.download),
              //     label: 'Kayıtlı Çeviriler'),
              BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.gear), label: 'Ayarlar'),
            ]),
      ),
    );
  }

  void _tabPage(index) async {
    var headerTitle = index == 0
        ? 'Messages'
        : index == 1
            ? 'Translator'
            : 'Account';
    _pageController.jumpToPage(index);
    _tabNotifier.value = index;
    _headerKey.currentState!.setHeaderTitle(headerTitle);
  }
}
