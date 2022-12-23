import 'package:agora_uikit/agora_uikit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/enum/call_type_enum.dart';
import '../../core/models/response/call_model.dart';
import '../../core/router/app_router.gr.dart';
import '../../core/service/database_service.dart';
import '../../core/service/permission_service.dart';
import '../../widgets/app_header.dart';
import 'account_view/account_view.dart';
import 'chat_list_view/chat_list_view.dart';
import 'translator_list_view/translator_list_view.dart';

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
    return StreamBuilder(
        stream: DatabaseService.instance.listenEveryCalling(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            if (data.docs.isNotEmpty) {
              callListener(data.docs.first.data(), data.docs.first.id);
            }
          }
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
                        icon: FaIcon(FontAwesomeIcons.users),
                        label: 'Tercümanlar'),
                    // BottomNavigationBarItem(
                    //     icon: FaIcon(FontAwesomeIcons.download),
                    //     label: 'Kayıtlı Çeviriler'),
                    BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.gear), label: 'Ayarlar'),
                  ]),
            ),
          );
        });
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

  void callListener(Map<String, dynamic> data, docId) async {
    await PermissionService.of(context)
        .getPermission([Permission.microphone, Permission.camera]);

    Call caller = Call.fromJson(data);
    caller.docId = docId;
    var conversations = await DatabaseService.instance.getConversations();

    var getConversation = conversations
        .firstWhere((e) => (e['members'] as List).contains(caller.senderId));
    var customer = await DatabaseService.instance
        .getCustomer(getConversation['members'].first);

    if (context.router.current.path != '/call') {
      context.router.push(CallRoute(
        conversationType: caller.conversationType,
        callType: CallType.callee,
        call: caller,
        conversationId: getConversation['conversationId'],
        customer: customer,
      ));
    }
  }
}
