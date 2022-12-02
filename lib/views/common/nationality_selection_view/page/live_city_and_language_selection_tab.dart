import 'package:flutter/material.dart';
import 'package:help_me_to_speak/core/models/response/language_model.dart';

import '../widget/nationality_selection_widget.dart';

class LiveCityAndLanguageSelectionTab extends StatelessWidget {
  final List<Language> data;
  const LiveCityAndLanguageSelectionTab({super.key, required this.data});

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
                  description:
                      'Şu anda bulunduğunuz ve dil konusunda yardım almak istediğiniz ülkeyi seçiniz.',
                  searchBarHint: 'Ülke ismi yazınız...'),
              Expanded(child: buildListTile(data))
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
              Expanded(child: buildListTile(data))
            ],
          ),
        ),
      ],
    );
  }
}
