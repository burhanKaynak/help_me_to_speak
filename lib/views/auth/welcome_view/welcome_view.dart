import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';

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
        title: 'Great translator for everyone',
        color: Colors.transparent),
    Slide(
        imageUrl: 'assets/images/slide_page_image_2.png',
        title: 'Anytime you need...',
        color: Colors.transparent),
    Slide(
        imageUrl: 'assets/images/slide_page_image_3.png',
        title: 'Instant help while talking',
        color: Colors.transparent),
    Slide(
        imageUrl: 'assets/images/slide_page_image_4.png',
        title: 'Great translator for everyone',
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
          fit: BoxFit.fitHeight,
        ),
      );

  Widget get _buildHeader => Container(
        margin: const EdgeInsets.all(30),
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
              children: const [Text('Skip'), Icon(Icons.chevron_right)],
            )
          ],
        ),
      );

  Widget get _buildBody => const SizedBox.shrink();

  Widget get _buildFooter => Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(_page[_pageNotifier.value].title,
                style: Theme.of(context).textTheme.headline4),
            ElevatedButton(
                onPressed: null,
                child: Row(
                  children: const [
                    Expanded(
                        child: Align(
                            alignment: Alignment.center,
                            child: Text('Sign in with BankID'))),
                    Icon(Icons.payment)
                  ],
                )),
            const Text(
              'Your translator are here \n for you 24/7',
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
