import 'dart:async';
import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:after_layout/after_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/core/mixin/file_picker_mix.dart';
import 'package:help_me_to_speak/core/service/database_service.dart';
import 'package:help_me_to_speak/core/service/storage_service.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/const/app_padding.dart';
import '../../../core/const/app_radius.dart';
import '../../../core/const/app_sizer.dart';
import '../../../core/const/app_spacer.dart';
import '../../../core/models/response/message_model.dart';
import '../../../themes/project_themes.dart';
import '../../../widgets/app_divider.dart';
import '../../../widgets/app_header.dart';

class ChatView extends StatefulWidget {
  final String userId;
  final String conversationId;
  const ChatView(
      {super.key, required this.userId, required this.conversationId});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView>
    with AfterLayoutMixin<ChatView>, FilePickerMix {
  final TextEditingController _textEditingController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  @override
  void dispose() {
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).padding.bottom;
    afterFirstLayout(context);

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
          Expanded(child: _streamBuilder),
          _buildTextField
        ],
      ),
    );
  }

  StreamBuilder get _streamBuilder => StreamBuilder(
      stream: DatabaseService.instance.getChatMessages(widget.conversationId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messages = List<Message>.from(
              snapshot.data.docs.map((e) => Message.fromJson(e.data())));
          messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
          afterFirstLayout(context);
          return ListView(
            addAutomaticKeepAlives: false,
            controller: _scrollController,
            children: messages.map<Widget>((e) {
              return ListTile(
                title: Align(
                  alignment: widget.userId != e.senderId
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: _buildTextBar(e),
                ),
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      });

  Widget _buildTextBar(Message message) {
    var formatDate = DateFormat('EEEE hh:mm').format(message.timestamp);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          formatDate,
          style:
              Theme.of(context).textTheme.caption!.copyWith(color: colorHint),
        ),
        AppSpacer.horizontalSmallSpace,
        InkWell(
          onTap: () async {
            if (message.isFile) {
              var file = await StorageService.instance
                  .downloadFile(message.filePath!, widget.conversationId);
              _launchUrl(file);
            }
          },
          child: Container(
            constraints: BoxConstraints(maxWidth: 275.r),
            padding: AppPadding.layoutPadding,
            decoration: BoxDecoration(
                color: message.senderId != widget.userId
                    ? Colors.white
                    : colorLightGreen.withAlpha(30),
                borderRadius: AppRadius.rectangleRadius),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (message.isFile)
                    const FaIcon(FontAwesomeIcons.download,
                        color: Colors.blueAccent),
                  if (message.isFile) AppSpacer.horizontalSmallSpace,
                  Flexible(
                    child: Text(
                      message.message,
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                          color: !message.isFile
                              ? Colors.black
                              : Colors.blueAccent,
                          decoration: !message.isFile
                              ? TextDecoration.none
                              : TextDecoration.underline),
                    ),
                  ),
                ]),
          ),
        )
      ],
    );
  }

  Widget get _buildTextField => Padding(
        padding: AppPadding.messageFieldPadding,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          padding: AppPadding.inputPadding,
          child: TextField(
              focusNode: _focusNode,
              controller: _textEditingController,
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
                    children: [
                      IconButton(
                          onPressed: () {
                            _showActionSheet((file) async {
                              await context.router.pop();
                              if (file != null) {
                                _showDocumentSheet(file);
                              }
                            });
                          },
                          icon: FaIcon(FontAwesomeIcons.paperclip)),
                      IconButton(
                          onPressed: () {
                            DatabaseService.instance.putMessage(
                                widget.conversationId,
                                _textEditingController.text,
                                false,
                                null);
                            afterFirstLayout(context);
                            _textEditingController.clear();
                          },
                          icon: const FaIcon(FontAwesomeIcons.paperPlane))
                    ],
                  ),
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Mesajınızı buraya yazınız.',
                  border: InputBorder.none)),
        ),
      );

  Future<void> _launchUrl(File file) async {
    Uri uri = Uri.file(file.path);
    if (!File(uri.toFilePath()).existsSync()) {
      throw '$uri does not exist!';
    }
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  _showDocumentSheet(File file) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: AppRadius.rectangleRadius.topRight,
              topLeft: AppRadius.rectangleRadius.topLeft),
        ),
        padding: AppPadding.layoutPadding,
        child: Column(
          children: [
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const FaIcon(FontAwesomeIcons.file),
                AppSpacer.horizontalSmallSpace,
                Expanded(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    file.path.split('/').last,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: Colors.black),
                  ),
                )
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () => context.router.pop(),
                    child: Text(
                      'İptal',
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Colors.redAccent),
                    )),
                TextButton(
                    onPressed: () async {
                      var result = await StorageService.instance
                          .putConversationMedia(widget.conversationId, file);
                      await DatabaseService.instance.putMessage(
                          widget.conversationId,
                          _textEditingController.text,
                          true,
                          result);

                      await context.router.pop();
                    },
                    child: Text('Gönder'))
              ],
            )
          ],
        ),
      ),
    );
  }

  _showActionSheet(Function(File?) onTap) => showAdaptiveActionSheet(
        context: context,
        androidBorderRadius: 30,
        actions: <BottomSheetAction>[
          BottomSheetAction(
              title: Text(
                'Fotoğraf ve Video Arşivi',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.lightBlue),
              ),
              onPressed: (context) async {
                var result = await pickFiles(type: FileType.image);
                onTap(result);
              }),
          BottomSheetAction(
              title: Text(
                'Belge',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.lightBlue),
              ),
              onPressed: (context) async {
                var result = await pickFiles(
                    type: FileType.custom,
                    custom: ['doc', 'pdf', 'word', 'txt']);
                onTap(result);
              }),
        ],
        cancelAction: CancelAction(
            title: const Text(
                'Cancel')), // onPressed parameter is optional by default will dismiss the ActionSheet
      );

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }
}
