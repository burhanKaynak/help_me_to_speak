import 'package:flutter/material.dart';
import 'package:help_me_to_speak/core/models/response/language_model.dart';

import '../widget/nationality_selection_widget.dart';

class SupportLanguagesSelectionTab extends StatelessWidget {
  final List<Language> data;
  const SupportLanguagesSelectionTab({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildListHeader(context,
            title: 'Yardım almak istediğiniz dil?',
            description: 'Hangi dil konusunda yardıma ihtiyacınız var?',
            searchBarHint: 'Bir dil yazınız...'),
        Expanded(child: buildListTile(data))
      ],
    );
  }
}
