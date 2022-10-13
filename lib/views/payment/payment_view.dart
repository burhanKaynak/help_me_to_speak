import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/themes/project_themes.dart';
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

  Widget get _buildTabBarView => TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        children: [_buildTab, Placeholder()],
      );

  Widget get _buildTab => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hizmet',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: colorDarkGreen, fontWeight: FontWeight.w600),
                ),
                Text(
                  'Ücret',
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: colorDarkGreen, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const Divider(
            height: 0.5,
            thickness: 1.5,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FaIcon(FontAwesomeIcons.video),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text('2 Dakika 1 Saniye Görüntülü Görüşme:',
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black45)),
                ),
                Text('40 kr',
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: colorDarkGreen))
              ],
            ),
          ),
          const Divider(
            height: 0.5,
            thickness: 1.5,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.phone),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text('1 Dakika 30 Saniye Sesli Görüşme:',
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black45)),
                ),
                Text('15 kr',
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: colorDarkGreen))
              ],
            ),
          ),
          const Divider(
            height: 0.5,
            thickness: 1.5,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.download),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text('1 Dosya İndirmesi:',
                      textAlign: TextAlign.start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black45)),
                ),
                Text('40 kr',
                    textAlign: TextAlign.end,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: colorDarkGreen))
              ],
            ),
          ),
          const Divider(
            height: 0.5,
            thickness: 1.5,
            color: Colors.white,
          ),
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
            padding: const EdgeInsets.all(20.0),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: colorLightGreen),
                  borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(10),
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
                      width: 60,
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/Visa_Inc._logo.svg/2560px-Visa_Inc._logo.svg.png'),
                ],
              ),
            ),
          ),
          Text('Ödeme Yöntemini Değiştir',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: colorLightGreen, fontWeight: FontWeight.w500)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
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
}
