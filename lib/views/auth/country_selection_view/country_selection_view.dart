import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/const/app_padding.dart';
import '../../../core/const/app_sizer.dart';
import '../../../core/const/app_spacer.dart';
import '../../../themes/project_themes.dart';
import '../../../widgets/app_divider.dart';
import '../../../widgets/app_header.dart';
import '../../../widgets/app_search_field.dart';

class Country {
  final String title;
  final IconData icon;
  Country({required this.title, required this.icon});
}

class Lang {
  final String title;
  final IconData icon;
  Lang({required this.title, required this.icon});
}

class CountrySelectionView extends StatefulWidget {
  const CountrySelectionView({super.key});

  @override
  State<CountrySelectionView> createState() => _CountrySelectionViewState();
}

class _CountrySelectionViewState extends State<CountrySelectionView> {
  final List<Country> _countries = <Country>[
    Country(title: 'İsveç', icon: FontAwesomeIcons.globe),
    Country(title: 'Türkiye', icon: FontAwesomeIcons.globe),
    Country(title: 'İngiltere', icon: FontAwesomeIcons.globe),
  ];

  final List<Lang> _languages = <Lang>[
    Lang(title: 'İsveççe', icon: FontAwesomeIcons.globe),
    Lang(title: 'Türkçe', icon: FontAwesomeIcons.globe),
    Lang(title: 'İngilizce', icon: FontAwesomeIcons.globe),
    Lang(title: 'Almanca', icon: FontAwesomeIcons.globe),
    Lang(title: 'İtalyanca', icon: FontAwesomeIcons.globe),
    Lang(title: 'Norveççe', icon: FontAwesomeIcons.globe),
    Lang(title: 'Flemenkçe', icon: FontAwesomeIcons.globe),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppHeader(
          title: 'Ülke Ve Dil Seçimi',
        ),
        body: _step2);
  }

  Widget get _step1 => Column(
        children: [
          Expanded(
              flex: 5,
              child: _sectionCountry(
                  title: 'Yaşadığınız Ülke?',
                  description:
                      'Şu anda bulunduğunuz ve dil konusunda yardım almak istediğiniz ülkeyi seçiniz.',
                  searchBarHint: 'Ülke ismi yazınız...')),
          Expanded(
              flex: 5,
              child: _sectionMainLanguage(
                  title: 'Diliniz?',
                  description:
                      'Mevcut (yardım gerekmeksizin) konuşabildiğiniz dilleri seçiniz.',
                  searchBarHint: 'Bir dil yazınız...')),
          Expanded(
            flex: 1,
            child: Padding(
              padding: AppPadding.horizontalPaddingMedium,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: null,
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
                      onPressed: null,
                      child: Row(
                        children: [
                          const Text('Devam'),
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            size: AppSizer.iconSmall,
                          )
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      );

  Widget get _step2 => Column(
        children: [
          Expanded(
              flex: 10,
              child: _sectionSupportLanguage(
                  title: 'Yardım almak istediğiniz dil?',
                  description: 'Hangi dil konusunda yardıma ihtiyacınız var?',
                  searchBarHint: 'Bir dil yazınız...')),
          Expanded(
            flex: 1,
            child: Padding(
              padding: AppPadding.horizontalPaddingMedium,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: null,
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
                      onPressed: null,
                      child: Row(
                        children: [
                          const Text('Devam'),
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            size: AppSizer.iconSmall,
                          )
                        ],
                      )),
                ],
              ),
            ),
          )
        ],
      );

  Widget _sectionCountry(
          {required String title,
          required String description,
          required String searchBarHint}) =>
      Column(
        children: [
          Padding(
            padding: AppPadding.layoutPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: colorDarkGreen, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.black38),
                ),
                AppSpacer.verticalMediumSpace,
                AppSearchBarField(
                  hint: searchBarHint,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: AppPadding.horizontalPaddingMedium,
                      child: CheckboxListTile(
                        value: true,
                        onChanged: (value) => null,
                        title: Row(
                          children: [
                            FaIcon(_countries[index].icon),
                            AppSpacer.horizontalMediumSpace,
                            Text(
                              _countries[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),
                    AppDivider(
                        height: AppSizer.dividerH,
                        tickness: AppSizer.dividerTicknessSmall)
                  ],
                );
              },
              itemCount: _countries.length,
            ),
          ),
          const FaIcon(FontAwesomeIcons.chevronDown)
        ],
      );
  Widget _sectionMainLanguage(
          {required String title,
          required String description,
          required String searchBarHint}) =>
      Column(
        children: [
          Padding(
            padding: AppPadding.layoutPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: colorDarkGreen, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.black38),
                ),
                AppSpacer.verticalMediumSpace,
                AppSearchBarField(
                  hint: searchBarHint,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: AppPadding.horizontalPaddingMedium,
                      child: CheckboxListTile(
                        value: true,
                        onChanged: (value) => null,
                        title: Row(
                          children: [
                            FaIcon(_languages[index].icon),
                            AppSpacer.horizontalMediumSpace,
                            Text(
                              _languages[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),
                    AppDivider(
                        height: AppSizer.dividerH,
                        tickness: AppSizer.dividerTicknessSmall)
                  ],
                );
              },
              itemCount: _languages.length,
            ),
          ),
          const FaIcon(FontAwesomeIcons.chevronDown)
        ],
      );

  Widget _sectionSupportLanguage(
          {required String title,
          required String description,
          required String searchBarHint}) =>
      Column(
        children: [
          Padding(
            padding: AppPadding.layoutPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: colorDarkGreen, fontWeight: FontWeight.bold),
                ),
                Text(
                  description,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.black38),
                ),
                AppSpacer.verticalMediumSpace,
                AppSearchBarField(
                  hint: searchBarHint,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: AppPadding.horizontalPaddingMedium,
                      child: CheckboxListTile(
                        value: true,
                        onChanged: (value) => null,
                        title: Row(
                          children: [
                            FaIcon(_languages[index].icon),
                            AppSpacer.horizontalMediumSpace,
                            Text(
                              _languages[index].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.black54),
                            )
                          ],
                        ),
                      ),
                    ),
                    AppDivider(
                        height: AppSizer.dividerH,
                        tickness: AppSizer.dividerTicknessSmall)
                  ],
                );
              },
              itemCount: _languages.length,
            ),
          ),
          const Align(
              alignment: Alignment.topCenter,
              child: FaIcon(FontAwesomeIcons.chevronDown))
        ],
      );
}
