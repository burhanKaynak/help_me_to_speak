import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:help_me_to_speak/core/enum/app_route_path_enum.dart';
import 'package:im_stepper/stepper.dart';

import '../../../core/const/app_padding.dart';
import '../../../core/locale/locale_keys.g.dart';

class Slide {
  final String imageUrl;
  final String title;
  final Color color;
  Slide({required this.imageUrl, required this.title, required this.color});
}

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final List<Slide> _page = <Slide>[
    Slide(
        imageUrl: 'assets/images/slide_page_image_1.png',
        title: LocaleKeys.welcome_page_great_translator.tr(),
        color: Colors.transparent),
    Slide(
        imageUrl: 'assets/images/slide_page_image_2.png',
        title: LocaleKeys.welcome_page_anytime_you.tr(),
        color: Colors.transparent),
    Slide(
        imageUrl: 'assets/images/slide_page_image_3.png',
        title: LocaleKeys.welcome_page_instant_help.tr(),
        color: Colors.transparent),
    Slide(
        imageUrl: 'assets/images/slide_page_image_4.png',
        title: LocaleKeys.welcome_page_great_translator.tr(),
        color: Colors.transparent)
  ];

  final ValueNotifier<int> _pageNotifier = ValueNotifier(0);
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              PageView.builder(
                onPageChanged: (value) => _pageNotifier.value = value,
                itemCount: _page.length,
                controller: _pageController,
                itemBuilder: (context, index) => _buildSlideItem(_page[index]),
              ),
              ValueListenableBuilder(
                valueListenable: _pageNotifier,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      _buildHeader,
                      Expanded(child: _buildBody),
                      _buildFooter
                    ],
                  );
                },
              ),
            ],
          )),
    );
  }

  Widget _buildSlideItem(Slide slide) => SizedBox.expand(
        child: Image.asset(
          slide.imageUrl,
          fit: BoxFit.fitWidth,
        ),
      );

  Widget get _buildHeader => Container(
        margin: AppPadding.layoutPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.language),
                Text('Sweden'),
              ],
            ),
            Row(
              children: [Text(LocaleKeys.skip.tr()), Icon(Icons.chevron_right)],
            )
          ],
        ),
      );

  Widget get _buildBody => const SizedBox.shrink();

  Widget get _buildFooter => Padding(
        padding: AppPadding.layoutPadding,
        child: Column(
          children: [
            Text(_page[_pageNotifier.value].title,
                style: Theme.of(context).textTheme.headline4),
            ElevatedButton(
                onPressed: () =>
                    context.router.replaceNamed(RoutePath.auth.value),
                child: Row(
                  children: [
                    Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text(LocaleKeys.sign_in.tr()))),
                    const Icon(Icons.payment)
                  ],
                )),
            Text(
              LocaleKeys.welcome_page_they_are_here.tr(),
              textAlign: TextAlign.center,
            ),
            _buildDots
          ],
        ),
      );

  Widget get _buildDots => DotStepper(
        activeStep: _pageNotifier.value,
        dotCount: _page.length,
        dotRadius: 15,
        shape: Shape.pipe,
        spacing: 10,
        indicator: Indicator.worm,
        onDotTapped: (index) {
          _pageController.jumpToPage(index);
          _pageNotifier.value = index;
        },
      );
}
