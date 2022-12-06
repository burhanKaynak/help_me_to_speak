import 'package:flutter/material.dart';
import 'package:help_me_to_speak/core/bloc/country_cubit/country_cubit.dart';
import 'package:help_me_to_speak/core/models/response/language_model.dart';

import '../widget/nationality_selection_widget.dart';

class SupportLanguagesSelectionTab extends StatelessWidget {
  final List<Language> data;
  final CountryCubit countryCubit;
  const SupportLanguagesSelectionTab(
      {super.key, required this.data, required this.countryCubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildListHeader(context,
            title: 'Yardım almak istediğiniz dil?',
            description: 'Hangi dil konusunda yardıma ihtiyacınız var?',
            searchBarHint: 'Bir dil yazınız...'),
        Expanded(
            child: buildListTile(
          data,
          countryCubit.selectedSupportLanguage,
          (value, Language item) {
            var selectedSupportLanguage = countryCubit.selectedSupportLanguage;
            if (value!) {
              selectedSupportLanguage.value =
                  List<Language>.from(selectedSupportLanguage.value)..add(item);
            } else {
              selectedSupportLanguage.value
                  .removeWhere((e) => e.docId == item.docId);

              selectedSupportLanguage.value =
                  List<Language>.from(selectedSupportLanguage.value);
            }
          },
        ))
      ],
    );
  }
}
