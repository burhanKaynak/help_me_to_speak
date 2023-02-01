import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../core/const/app_padding.dart';
import '../../../core/const/app_sizer.dart';
import '../../../core/const/app_spacer.dart';
import '../../../core/models/response/coin_model.dart';
import '../../../widgets/app_bottom_sheets.dart';
import '../../../widgets/app_buttons.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/app_input.dart';

class ProductView extends StatelessWidget {
  final List<Coin> coins = [
    Coin(150, 150),
    Coin(100, 100),
    Coin(50, 50),
    Coin(25, 25),
  ];

  ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        title: 'Ürünler',
        backButton: true,
      ),
      body: Padding(
        padding: AppPadding.layoutPadding,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemCount: coins.length,
          itemBuilder: (BuildContext context, int index) =>
              _gridWidget(coins[index], context),
        ),
      ),
    );
  }

  final String _coinThumb =
      'https://freepngimg.com/thumb/money/25681-9-cartoon-coin-transparent-background.png';

  Widget _gridWidget(Coin coin, BuildContext context) => InkWell(
        onTap: () => _openCreditCardSheet(context, coin),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: AppPadding.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                    flex: 5,
                    child: CachedNetworkImage(
                        imageUrl: _coinThumb, fit: BoxFit.contain)),
                Expanded(
                  child: Text(
                    textAlign: TextAlign.center,
                    '${coin.quantity.toString()} TL',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        ),
      );

  void _openCreditCardSheet(BuildContext context, Coin coin) =>
      appShowModalBottomSheet(context,
          sheetHeight: SheetHeight.high,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                      width: AppSizer.imageSmallW,
                      height: AppSizer.imageSmallW,
                      child: CachedNetworkImage(imageUrl: _coinThumb)),
                  AppSpacer.verticalSmallSpace,
                  Text(
                    textAlign: TextAlign.center,
                    '${coin.quantity.toString()} TL',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  )
                ],
              ),
              AppSpacer.verticalMediumSpace,
              const CardFormField(
                enablePostalCode: false,
              ),
              buildButton(onPressed: () => null, text: 'Öde')
            ],
          ));

  Widget _creditCardForm() => Form(
        child: Column(
          children: [
            const AppTextFormField(
              hint: '•••• •••• •••• ••••',
            ),
            AppSpacer.verticalSmallSpace,
            Row(
              children: [
                const Flexible(
                    child: AppTextFormField(
                  hint: '••/••',
                )),
                AppSpacer.horizontalSmallSpace,
                const Flexible(
                    child: AppTextFormField(
                  hint: 'CCV',
                ))
              ],
            ),
            AppSpacer.verticalSmallSpace,
          ],
        ),
      );
}
