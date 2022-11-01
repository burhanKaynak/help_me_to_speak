import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:help_me_to_speak/views/auth/auth_view/sign_in_view/sign_in_view.dart';
import 'package:help_me_to_speak/views/auth/auth_view/sign_up_view/sign_up_view.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: false, viewportFraction: 1);
  late int _currentPage;
  final ValueNotifier<String> _pageNameNotifier =
      ValueNotifier<String>('Hesap Oluştur');

  bool _animationComplated = true;

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: padding.bottom,
                top: padding.top * 1.5)
            .r,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 1, child: _buildLogo),
              Expanded(
                flex: 3,
                child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    pageSnapping: true,
                    controller: _pageController,
                    onPageChanged: (value) {
                      if (value == 0) {
                        _pageNameNotifier.value = 'Hesap Oluştur';
                      } else {
                        _pageNameNotifier.value = 'Giriş Yap';
                      }
                    },
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      _currentPage = index;
                      return index == 0
                          ? const SingInView()
                          : const SignUpView();
                    }),
              ),
              TextButton(
                  onPressed: _changePage,
                  child: ValueListenableBuilder(
                    valueListenable: _pageNameNotifier,
                    builder: (context, value, child) => Text(value),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _changePage() async {
    if (_currentPage == 0 && _animationComplated) {
      _animationComplated = false;
      await _pageController.nextPage(
          duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
      _animationComplated = true;
    } else if (_animationComplated) {
      _animationComplated = false;
      await _pageController.previousPage(
          duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
      _animationComplated = true;
    }
  }

  Widget get _buildLogo => Padding(
        padding: EdgeInsets.all(20.r),
        child: FlutterLogo(
          size: 100.r,
        ),
      );
}
