import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/themes/project_themes.dart';
import 'package:help_me_to_speak/views/payment/payment_info_view/payment_tab/payment_info_tab.dart';
import 'package:help_me_to_speak/views/payment/payment_info_view/payment_tab/payment_order_history_tab.dart';
import 'package:help_me_to_speak/widgets/app_header.dart';

//TODO: Hacı burda çok karmaşık kod var bunları düzenle.
class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        title: 'Ödeme',
        backButton: true,
      ),
      body: _buildTabBar,
    );
  }

  Widget get _buildTabBar => DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Column(
          children: [
            TabBar(
              labelColor: colorLightGreen,
              indicatorColor: colorLightGreen,
              unselectedLabelColor: Colors.black45,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      FaIcon(FontAwesomeIcons.hourglass),
                      Text(
                        'Bekleyen Ödemeler',
                      )
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      FaIcon(FontAwesomeIcons.clockRotateLeft),
                      Text('Ödeme Geçmişi')
                    ],
                  ),
                )
              ],
            ),
            Expanded(child: _buildTabBarView)
          ],
        ),
      );
  Widget get _buildTabBarView => const TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [PaymentInfoTab(), PaymentOrderHistoryTab()],
      );
}
