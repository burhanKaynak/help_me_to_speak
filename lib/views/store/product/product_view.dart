import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../core/bloc/payment_bloc/payment_bloc.dart';
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
    Coin(id: 0, quantity: 1, price: 150),
    Coin(id: 1, quantity: 1, price: 100),
    Coin(id: 2, quantity: 1, price: 50),
    Coin(id: 3, quantity: 1, price: 25),
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
                    '${coin.price.toString()} TL',
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
          child: BlocProvider<PaymentBloc>(
            create: (context) => PaymentBloc(),
            child: BlocBuilder<PaymentBloc, PaymentState>(
              builder: (context, state) {
                CardFormEditController controller = CardFormEditController(
                    initialDetails: state.cardFieldInputDetails);
                if (state.status == PaymentStatus.initial) {
                  return Column(
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
                            '${coin.price.toString()} TL',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.black),
                          )
                        ],
                      ),
                      AppSpacer.verticalMediumSpace,
                      CardFormField(
                        controller: controller,
                        enablePostalCode: false,
                      ),
                      buildButton(
                          onPressed: () {
                            (controller.details.complete)
                                ? context.read<PaymentBloc>().add(
                                    PaymentCreateIntent(
                                        billingDetails: BillingDetails(
                                            email: FirebaseAuth
                                                .instance.currentUser!.email),
                                        items: [coin.toJson()]))
                                : print(false);
                            // context.read<PaymentBloc>().add(PaymentStart());
                          },
                          text: 'Öde')
                    ],
                  );
                } else if (state.status == PaymentStatus.succes) {
                  context.router.pop();
                } else if (state.status == PaymentStatus.failure) {
                  return Text('Payment Failure');
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
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
