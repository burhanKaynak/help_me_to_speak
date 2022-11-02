import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../utils/const/app_padding.dart';
import '../../../../utils/const/app_spacer.dart';

class PaymentOrderHistoryTab extends StatelessWidget {
  const PaymentOrderHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.layoutPadding,
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) => Card(
                child: Padding(
                  padding: AppPadding.cardPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLine(context,
                          title: '2 Dakika 1 Saniye Görüntülü Görüşme: 40 kr',
                          icon: FontAwesomeIcons.video),
                      AppSpacer.verticalSmallSpace,
                      _buildLine(context,
                          title: '1 Dakika 30 Saniye Sesli Görüşme: 15 kr',
                          icon: FontAwesomeIcons.phone),
                      AppSpacer.verticalSmallSpace,
                      _buildLine(context,
                          title: '1 Dosya İndirmesi: 40 kr',
                          icon: FontAwesomeIcons.download),
                      AppSpacer.verticalSmallSpace,
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('Toplam: 82 kr',
                            textAlign: TextAlign.end,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              )),
    );
  }

  Widget _buildLine(context, {required String title, required IconData icon}) =>
      Row(
        children: [
          FaIcon(icon),
          AppSpacer.horizontalSmallSpace,
          Text(title,
              textAlign: TextAlign.start,
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.black45)),
        ],
      );
}
