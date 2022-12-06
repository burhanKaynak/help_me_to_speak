import 'package:flutter/material.dart';
import 'package:help_me_to_speak/core/models/response/language_model.dart';

import '../../../../core/bloc/country_cubit/country_cubit.dart';
import '../widget/nationality_selection_widget.dart';

class LiveCityAndLanguageSelectionTab extends StatelessWidget {
  final CountryCubit countryCubit;
  final List<Language> data;
  const LiveCityAndLanguageSelectionTab(
      {super.key, required this.data, required this.countryCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              buildListHeader(context,
                  title: 'Yaşadığınız Ülke?',
                  onChanged: (val) => countryCubit.searchList(val),
                  description:
                      'Şu anda bulunduğunuz ve dil konusunda yardım almak istediğiniz ülkeyi seçiniz.',
                  searchBarHint: 'Ülke ismi yazınız...'),
              Expanded(
                  child: ValueListenableBuilder(
                      valueListenable: countryCubit.list,
                      builder: (context, value, child) => buildListTile(
                            value,
                            countryCubit.selectedCountry,
                            (value, Language item) {
                              var selectedCountry =
                                  countryCubit.selectedCountry;

                              if (value!) {
                                if (selectedCountry.value.isNotEmpty) return;

                                selectedCountry.value =
                                    List<Language>.from(selectedCountry.value)
                                      ..add(item);
                              } else {
                                selectedCountry.value
                                    .removeWhere((e) => e.docId == item.docId);

                                selectedCountry.value =
                                    List<Language>.from(selectedCountry.value);
                              }
                            },
                          )))
            ],
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              buildListHeader(context,
                  title: 'Diliniz?',
                  description:
                      'Mevcut (yardım gerekmeksizin) konuşabildiğiniz dilleri seçiniz.',
                  searchBarHint: 'Bir dil yazınız...'),
              Expanded(
                  child: ValueListenableBuilder(
                valueListenable: countryCubit.list,
                builder: (context, value, child) => buildListTile(
                  value,
                  countryCubit.selectedNativeLanguage,
                  (value, Language item) {
                    var selectedNativeLanguage =
                        countryCubit.selectedNativeLanguage;
                    if (value!) {
                      selectedNativeLanguage.value =
                          List<Language>.from(selectedNativeLanguage.value)
                            ..add(item);
                    } else {
                      selectedNativeLanguage.value
                          .removeWhere((e) => e.docId == item.docId);

                      selectedNativeLanguage.value =
                          List<Language>.from(selectedNativeLanguage.value);
                    }
                  },
                ),
              ))
            ],
          ),
        ),
      ],
    );
  }
}
