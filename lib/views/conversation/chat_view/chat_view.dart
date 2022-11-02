import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../themes/project_themes.dart';
import '../../../utils/const/app_padding.dart';
import '../../../utils/const/app_radius.dart';
import '../../../utils/const/app_sizer.dart';
import '../../../utils/const/app_spacer.dart';
import '../../../widgets/app_divider.dart';
import '../../../widgets/app_header.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final List<String> _messages = [
    'Deneme Mesajı1',
    'Deneme Mesajı2',
    'Deneme Mesajı3',
    'Deneme Mesajı4',
    'Deneme Mesajı5',
    'Deneme Mesajı6',
    'Deneme Mesajı7',
    'Deneme Mesajı8',
    'Deneme Mesajı9',
    'Deneme Mesajı10',
    'Deneme Mesajı11',
    'Deneme Mesajı12',
    'Deneme Mesajı13',
  ];

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    super.initState();
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).viewInsets.bottom;
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }
    return Scaffold(
      appBar: AppHeader(
        rightChild: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const FaIcon(FontAwesomeIcons.magnifyingGlass),
            AppSpacer.horizontalSmallSpace,
            const FaIcon(FontAwesomeIcons.phone),
            AppSpacer.horizontalSmallSpace,
            const FaIcon(FontAwesomeIcons.video),
          ],
        ),
        title: 'Angelina',
        backButton: true,
      ),
      body: Column(
        children: [
          AppDivider(
              height: AppSizer.dividerH,
              tickness: AppSizer.dividerTicknessSmall),
          Expanded(
              child: ListView.builder(
            controller: _scrollController,
            itemCount: _messages.length,
            itemBuilder: (context, index) => ListTile(
              title: Align(
                alignment: index % 2 == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: _buildTextBar(_messages[index], index % 2 != 0),
              ),
            ),
          )),
          _buildTextField
        ],
      ),
    );
  }

  Widget _buildTextBar(text, isWhite) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bugün: 15:02',
          style:
              Theme.of(context).textTheme.caption!.copyWith(color: colorHint),
        ),
        AppSpacer.horizontalSmallSpace,
        Container(
          padding: AppPadding.layoutPadding,
          decoration: BoxDecoration(
              color: isWhite ? Colors.white : colorLightGreen.withAlpha(30),
              borderRadius: AppRadius.rectangleRadius),
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }

  Widget get _buildTextField => Padding(
        padding: AppPadding.layoutPadding,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: AppPadding.inputPadding,
          child: TextField(
              textAlign: TextAlign.left,
              textAlignVertical: TextAlignVertical.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: Colors.black),
              decoration: InputDecoration(
                  isDense: true,
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      IconButton(
                          onPressed: null,
                          icon: FaIcon(FontAwesomeIcons.paperclip)),
                      IconButton(
                          onPressed: null,
                          icon: FaIcon(FontAwesomeIcons.paperPlane))
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Mesajınızı buraya yazınız.',
                  border: InputBorder.none)),
        ),
      );
}
