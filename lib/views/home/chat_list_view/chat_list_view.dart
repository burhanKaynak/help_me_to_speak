import 'package:flutter/material.dart';

import '../../../themes/project_themes.dart';
import '../../../utils/const/app_padding.dart';
import '../../../utils/const/app_sizer.dart';
import '../../../utils/const/app_spacer.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_divider.dart';
import '../../../widgets/app_search_field.dart';

class Chat {
  final String fullName;
  final String avatar;
  final bool isOnline;
  final String lastSeen;
  final String lastMessage;

  Chat(
      {required this.fullName,
      required this.avatar,
      required this.isOnline,
      required this.lastSeen,
      required this.lastMessage});
}

List<Chat> _chats = <Chat>[
  Chat(
      fullName: 'Angelina',
      avatar:
          'https://img.freepik.com/free-photo/modern-woman-taking-selfie_23-2147893976.jpg?w=1380&t=st=1664901155~exp=1664901755~hmac=9127862f43915452a82d24ac02ba9768ff5b63354f3f46bcaf54bbf830d34235',
      isOnline: true,
      lastSeen: 'Pazartesi',
      lastMessage: 'Fotoğraf ulaştı, tercüme ediyorum.'),
  Chat(
      fullName: 'Bence Marcus',
      avatar:
          'https://img.freepik.com/free-photo/close-up-young-man-looking-camera-against-grey-wall_23-2148130316.jpg?w=1380&t=st=1664901174~exp=1664901774~hmac=1ea39e8e55052b82783e844d869433a19aae1ee2f9b75e36e25892990dabaaa0',
      isOnline: false,
      lastSeen: '15:20',
      lastMessage: 'Yahu Orhan değilim ben.'),
  Chat(
      fullName: 'Adam Wolf',
      avatar:
          'https://www.ktoeos.org/wp-content/uploads/2021/11/default-avatar.png',
      isOnline: false,
      lastSeen: '2 hafta önce',
      lastMessage: 'Evet, halletim onu.')
];

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: AppPadding.horizontalPaddingMedium,
          child: Column(
            children: [
              AppSearchBarField(),
              AppSpacer.verticalLargeSpace,
              _buildFilterBar,
              AppSpacer.verticalLargeSpace,
            ],
          ),
        ),
        AppDivider(
            height: AppSizer.dividerH, tickness: AppSizer.dividerTicknessSmall),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: _chats.length,
            itemBuilder: (context, index) => AppCard(chat: _chats[index]),
          ),
        )
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
