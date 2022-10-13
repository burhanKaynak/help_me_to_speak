import 'package:flutter/material.dart';
import 'package:help_me_to_speak/widgets/app_silver_grid_delegate_fixed_cross_axis_count_and_fixed_heigth.dart';

import '../../../themes/project_themes.dart';
import '../../../widgets/app_circle_avatar.dart';
import '../../../widgets/app_search_field.dart';

//TODO: Hacı burda çok karmaşık kod var bunları düzenle.
class Translator {
  final String fullName;
  final String avatar;
  final bool isOnline;
  final bool hasChat;

  Translator({
    required this.fullName,
    required this.hasChat,
    required this.avatar,
    required this.isOnline,
  });
}

class TranslatorListView extends StatefulWidget {
  const TranslatorListView({super.key});

  @override
  State<TranslatorListView> createState() => _TranslatorListViewState();
}

class _TranslatorListViewState extends State<TranslatorListView> {
  final List<Translator> _translators = <Translator>[
    Translator(
        fullName: 'Angelina',
        avatar:
            'https://img.freepik.com/free-photo/modern-woman-taking-selfie_23-2147893976.jpg?w=1380&t=st=1664901155~exp=1664901755~hmac=9127862f43915452a82d24ac02ba9768ff5b63354f3f46bcaf54bbf830d34235',
        isOnline: true,
        hasChat: true),
    Translator(
        fullName: 'Bence Marcus',
        avatar:
            'https://img.freepik.com/free-photo/close-up-young-man-looking-camera-against-grey-wall_23-2148130316.jpg?w=1380&t=st=1664901174~exp=1664901774~hmac=1ea39e8e55052b82783e844d869433a19aae1ee2f9b75e36e25892990dabaaa0',
        isOnline: false,
        hasChat: true),
    Translator(
        fullName: 'Adam Wolf',
        avatar:
            'https://www.ktoeos.org/wp-content/uploads/2021/11/default-avatar.png',
        isOnline: false,
        hasChat: true),
    Translator(
        fullName: 'İsim 1',
        avatar:
            'https://www.ktoeos.org/wp-content/uploads/2021/11/default-avatar.png',
        isOnline: false,
        hasChat: false),
    Translator(
        fullName: 'İsim 2',
        avatar:
            'https://www.ktoeos.org/wp-content/uploads/2021/11/default-avatar.png',
        isOnline: false,
        hasChat: false),
    Translator(
        fullName: 'İsim 3',
        avatar:
            'https://www.ktoeos.org/wp-content/uploads/2021/11/default-avatar.png',
        isOnline: false,
        hasChat: false),
    Translator(
        fullName: 'İsim 4',
        avatar:
            'https://www.ktoeos.org/wp-content/uploads/2021/11/default-avatar.png',
        isOnline: false,
        hasChat: false),
    Translator(
        fullName: 'İsim 5',
        avatar:
            'https://www.ktoeos.org/wp-content/uploads/2021/11/default-avatar.png',
        isOnline: false,
        hasChat: false),
    Translator(
        fullName: 'İsim 6',
        avatar:
            'https://www.ktoeos.org/wp-content/uploads/2021/11/default-avatar.png',
        isOnline: false,
        hasChat: false),
  ];
  ThemeData? _themeData;

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);

    final Size size = MediaQuery.of(context).size;
    final double itemHeigth = (size.height - kToolbarHeight - 24) / 2.4;
    final double itemWidth = size.width / 2;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          AppSearchBarField(),
          const SizedBox(
            height: 20,
          ),
          _buildFilterBar,
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: GridView.builder(
            itemCount: _translators.length,
            shrinkWrap: true,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                    height: 180),
            itemBuilder: (context, index) {
              var item = _translators[index];
              return Column(
                children: [
                  SizedBox(
                    height: 135,
                    child: AppCircleAvatar(
                      url: item.avatar,
                      isOnline: item.isOnline,
                      langs: const ['asdasd', 'asdas'],
                      showAddRemoveButton: true,
                      hasChat: item.hasChat,
                    ),
                  ),
                  _buildNameAndState(
                      fullName: item.fullName, isOnline: item.isOnline)
                ],
              );
            },
          ))
        ],
      ),
    );
  }

  Widget _buildNameAndState(
      {required String fullName, required bool isOnline}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          fullName,
          style: _themeData!.textTheme.bodyText1!
              .copyWith(fontSize: 16, color: colorDarkGreen),
        ),
        Text(isOnline ? 'Şu an Çeviriye Hazır' : 'Çevirimdışı',
            style: _themeData!.textTheme.caption!
                .copyWith(color: isOnline ? colorLightGreen : colorHint)),
      ],
    );
  }

  Widget get _buildFilterBar => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildRichText(filter: 'Dil:', contents: 'İsveççe, İngilizce +1'),
          _buildRichText(filter: 'Durum:', contents: 'Çevrimiçi'),
          _buildRichText(filter: 'İletişim:', contents: 'Yazı'),
        ],
      );
  Widget _buildRichText({required String filter, required String contents}) =>
      RichText(
          text: TextSpan(children: [
        TextSpan(
            text: '$filter ',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: colorHint)),
        TextSpan(
            text: contents,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: colorLightGreen)),
      ]));
}
