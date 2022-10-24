import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../themes/project_themes.dart';

class PaymentInfoTab extends StatelessWidget {
  const PaymentInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPaymentInfoHeader(context),
        _buildPaymentInfo(context),
        _buildPaymentTotal(context),
        _buildSavedCreditCards(context),
        _buildPayButton(context)
      ],
    );
  }

  Widget _buildPaymentInfoHeader(context) => Padding(
        padding: const EdgeInsets.all(20.0).r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hizmet',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: colorDarkGreen, fontWeight: FontWeight.w600),
            ),
            Text(
              'Ücret',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: colorDarkGreen, fontWeight: FontWeight.w600),
            )
          ],
        ),
      );

  Widget _buildPaymentInfo(context) => Column(
        children: [
          const Divider(
            height: 0.5,
            thickness: 1.5,
            color: Colors.white,
          ),
          _buildLine(context,
              icon: FontAwesomeIcons.video,
              title: '2 Dakika 1 Saniye Görüntülü Görüşme:',
              price: '40 kr'),
          const Divider(
            height: 0.5,
            thickness: 1.5,
            color: Colors.white,
          ),
          _buildLine(context,
              icon: FontAwesomeIcons.phone,
              title: '1 Dakika 30 Saniye Sesli Görüşme:',
              price: '15 kr'),
          const Divider(
            height: 0.5,
            thickness: 1.5,
            color: Colors.white,
          ),
          _buildLine(context,
              icon: FontAwesomeIcons.download,
              title: '1 Dosya İndirmesi:',
              price: '40 kr'),
          const Divider(
            height: 0.5,
            thickness: 1.5,
            color: Colors.white,
          ),
        ],
      );

  Widget _buildPaymentTotal(context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text('%10 Uygulama Hizmet Bedeli:',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black45)),
                ),
                Expanded(
                  flex: 1,
                  child: Text('6 kr',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: colorDarkGreen)),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text('%18 İletişim Vergisi:',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black45)),
                ),
                Expanded(
                  flex: 1,
                  child: Text('11 kr',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: colorDarkGreen)),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5).r,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text('Toplam:',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Colors.black)),
                ),
                Expanded(
                  flex: 1,
                  child: Text('82 kr',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: colorDarkGreen)),
                )
              ],
            ),
          ),
        ],
      );

  Widget _buildSavedCreditCards(context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5).r,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: colorLightGreen),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Adam Wolf Johnson',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.black87)),
                      Text('... 4522 no ile biten kayıtlı kart',
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: Colors.black87))
                    ],
                  ),
                  CachedNetworkImage(
                      width: 60.w,
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png'),
                ],
              ),
            ),
          ),
          Text('Ödeme Yöntemini Değiştir',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: colorLightGreen, fontWeight: FontWeight.w500)),
        ],
      );

  Widget _buildPayButton(context) => Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Ödeme Koşullarını Okudum, Onaylıyorum.',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.w500)),
                Checkbox(
                  value: true,
                  onChanged: null,
                  shape: CircleBorder(),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ElevatedButton(
                onPressed: null,
                child: Row(
                  children: const [
                    Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('82 Kr Şimdi Öde'))),
                    FaIcon(FontAwesomeIcons.creditCard)
                  ],
                )),
          )
        ],
      );

  Widget _buildLine(context,
          {required String title,
          required IconData icon,
          required String price}) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            FaIcon(icon),
            10.horizontalSpace,
            Expanded(
              child: Text(title,
                  textAlign: TextAlign.start,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.black45)),
            ),
            Text(price,
                textAlign: TextAlign.end,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: colorDarkGreen))
          ],
        ),
      );
}
