// ignore_for_file: sort_child_properties_last

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/core/bloc/country_cubit/country_cubit.dart';
import 'package:help_me_to_speak/views/common/nationality_selection_view/page/live_city_and_language_selection_tab.dart';
import 'package:help_me_to_speak/views/common/nationality_selection_view/page/support_languages_selection_tab.dart';

import '../../../core/const/app_padding.dart';
import '../../../core/const/app_sizer.dart';
import '../../../widgets/app_header.dart';

class NationalitySelectionView extends StatefulWidget {
  const NationalitySelectionView({super.key});

  @override
  State<NationalitySelectionView> createState() =>
      _NationalitySelectionViewState();
}

class _NationalitySelectionViewState extends State<NationalitySelectionView> {
  final CountryCubit _countryCubit = CountryCubit()..getLanguages();
  final ValueNotifier<int> _pageNotifier = ValueNotifier(0);
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: false, viewportFraction: 1);
  bool _animationComplated = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppHeader(
          title: 'Ülke Ve Dil Seçimi',
        ),
        body: _countryBlocBuilder);
  }

  @override
  @protected
  @mustCallSuper
  void dispose() {
    _countryCubit.close();
    super.dispose();
  }

  BlocBuilder<CountryCubit, CountryState> get _countryBlocBuilder =>
      BlocBuilder<CountryCubit, CountryState>(
        bloc: _countryCubit,
        builder: (context, state) {
          if (state is CountryLoaded) {
            return Column(
              children: [
                Expanded(
                    child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (value) => _pageNotifier.value = value,
                  children: [
                    LiveCityAndLanguageSelectionTab(data: state.data),
                    SupportLanguagesSelectionTab(data: state.data)
                  ],
                  controller: _pageController,
                )),
                _buildFooter
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      );

  Widget get _buildFooter {
    return Padding(
      padding: AppPadding.horizontalPaddingMedium,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {
                if (_pageController.page == 0) {
                  context.router.pop();
                  return;
                }
                _changePage(false);
              },
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: AppSizer.iconSmall,
                  ),
                  const Text('Geri')
                ],
              )),
          ElevatedButton(
              onPressed: () {
                if (_pageController.page! > 0) {
                  return;
                }
                _changePage(true);
              },
              child: Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _pageNotifier,
                    builder: (context, value, child) {
                      return Text(value == 0 ? 'Devam' : 'Kaydet');
                    },
                  ),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: AppSizer.iconSmall,
                  )
                ],
              )),
        ],
      ),
    );
  }

  Future<void> _changePage(bool isNext) async {
    if (isNext && _animationComplated) {
      _animationComplated = false;
      await _pageController.nextPage(
          duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
      _animationComplated = true;
    } else if (!isNext && _animationComplated) {
      _animationComplated = false;

      await _pageController.previousPage(
          duration: const Duration(milliseconds: 150), curve: Curves.easeIn);
      _animationComplated = true;
    }
  }
}
