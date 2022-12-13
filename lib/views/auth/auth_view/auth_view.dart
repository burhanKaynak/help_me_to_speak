import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/const/app_padding.dart';
import '../../../core/locale/locale_keys.g.dart';
import 'sign_in_view/sign_in_view.dart';
import 'sign_up_view/sign_up_view.dart';

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
      ValueNotifier<String>(LocaleKeys.sign_in.tr());

  bool _animationComplated = true;

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;

    return Scaffold(
      body: Padding(
        padding: AppPadding.layoutPadding
            .copyWith(bottom: padding.bottom, top: padding.top * 1.5),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(flex: 1, child: _buildLogo),
              Expanded(
                flex: 2,
                child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    pageSnapping: true,
                    controller: _pageController,
                    onPageChanged: (value) {
                      if (value == 0) {
                        _pageNameNotifier.value = LocaleKeys.sign_in.tr();
                      } else {
                        _pageNameNotifier.value = LocaleKeys.sign_up.tr();
                      }
                    },
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      _currentPage = index;
                      return index == 0
                          ? SingInView(
                              onTapSignUp: _changePage,
                            )
                          : SignUpView(
                              onTapSignIn: _changePage,
                            );
                    }),
              ),
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
        padding: AppPadding.layoutPadding,
        child: FlutterLogo(
          size: 100.r,
        ),
      );
}
