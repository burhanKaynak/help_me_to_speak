import 'package:auto_route/auto_route.dart';
import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/bloc/conversation_bloc/conversation_bloc.dart';
import '../../../core/const/app_padding.dart';
import '../../../core/const/app_sizer.dart';
import '../../../core/const/app_spacer.dart';
import '../../../core/enum/available_conversation_type_enum.dart';
import '../../../core/enum/call_state_enum.dart';
import '../../../core/enum/translator_status_enum.dart';
import '../../../core/models/response/call_model.dart';
import '../../../core/models/response/language_model.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../core/service/auth_service.dart';
import '../../../core/service/database_service.dart';
import '../../../core/service/permission_service.dart';
import '../../../themes/project_themes.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/app_circle_image.dart';
import '../../../widgets/app_divider.dart';
import '../../../widgets/app_search_field.dart';
import '../../../widgets/app_selector.dart';
import '../../../widgets/app_shimmer.dart';

class ChatListView extends StatefulWidget {
  const ChatListView({super.key});

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  final ConversationBloc _conversationBloc = ConversationBloc()
    ..add(GetConversations());

  final ValueNotifier<String> _notifierLanguage = ValueNotifier('All'),
      _notifierStatus = ValueNotifier('All'),
      _notifierConversation = ValueNotifier('All');

  final List<S2Choice<AvailableConversationType>> _listConversationType = [
    S2Choice<AvailableConversationType>(
        meta: FontAwesomeIcons.solidMessage,
        title: AvailableConversationType.chat.value,
        value: AvailableConversationType.chat),
    S2Choice<AvailableConversationType>(
        meta: FontAwesomeIcons.video,
        title: AvailableConversationType.videoCall.value,
        value: AvailableConversationType.videoCall),
    S2Choice<AvailableConversationType>(
        meta: FontAwesomeIcons.phone,
        title: AvailableConversationType.voiceCall.value,
        value: AvailableConversationType.voiceCall),
  ];

  final List<S2Choice<TranslatorStatus>> _listTranslatorStatus = [
    S2Choice<TranslatorStatus>(
        meta: FontAwesomeIcons.user,
        title: TranslatorStatus.online.value,
        value: TranslatorStatus.online),
    S2Choice<TranslatorStatus>(
        meta: FontAwesomeIcons.userSlash,
        title: TranslatorStatus.busy.value,
        value: TranslatorStatus.busy),
  ];

  @override
  void dispose() {
    _notifierLanguage.dispose();
    _notifierStatus.dispose();
    _notifierConversation.dispose();

    _conversationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: AppPadding.horizontalPaddingMedium,
          child: Column(
            children: [
              AppSearchBarField(
                hint: 'Bir Tercüman Arayın',
                onChanged: (val) =>
                    _conversationBloc.add(SearchConversations(val)),
              ),
              AppSpacer.verticalLargeSpace,
              _buildFilterBar,
              AppSpacer.verticalLargeSpace,
            ],
          ),
        ),
        AppDivider(
            height: AppSizer.dividerH, tickness: AppSizer.dividerTicknessSmall),
        Expanded(
          child: BlocProvider<ConversationBloc>(
            create: (context) => _conversationBloc,
            child: _converstationBlocBuilder,
          ),
        )
      ],
    );
  }

  BlocBuilder<ConversationBloc, ConversationState>
      get _converstationBlocBuilder =>
          BlocBuilder<ConversationBloc, ConversationState>(
            builder: (context, state) {
              if (state is ConversationLoaded) {
                return ListView(
                  padding: EdgeInsets.zero,
                  children: state.chats
                      .map((e) => InkWell(
                          onTap: () => context.router.push(ChatRoute(
                                conversationId: e.conversationId,
                                translator: e.customer,
                              )),
                          child: AppCard(
                            chat: e,
                            langs: FutureBuilder(
                              future: DatabaseService.instance
                                  .getTranslatorSupportLanguagesByRef(
                                e.customer.languagesOfTranslate!,
                              ),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Wrap(
                                    spacing: 5,
                                    children: snapshot.data!
                                        .map((e) =>
                                            AppCircleImage(image: e.thumbnail!))
                                        .toList(),
                                  );
                                }
                                return buildCircleShimmer;
                              },
                            ),
                            onTapVoiceCall: () async {
                              PermissionService.of(context)
                                  .getPermission([Permission.microphone]);

                              Call call = Call(
                                AuthService.instance.currentUser!.uid,
                                CallState.calling,
                                DateTime.now(),
                                null,
                                'null',
                              );

                              call.docId = await DatabaseService.instance
                                  .makeCall(call, e.customer.uid);

                              context.router.push(CallRoute(
                                type: 0,
                                call: call,
                                conversationId: e.conversationId,
                                customer: e.customer,
                              ));
                            },
                            onTapVideoCall: () {
                              PermissionService.of(context).getPermission(
                                  [Permission.microphone, Permission.camera]);
                            },
                            onTapChat: () => context.router.push(ChatRoute(
                              conversationId: e.conversationId,
                              translator: e.customer,
                            )),
                          )))
                      .toList(),
                );
              }
              return const SizedBox.shrink();
            },
          );

  Widget get _buildFilterBar => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: FutureBuilder(
              future: DatabaseService.instance.getLanguages(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<S2Choice<Language>> list = snapshot.data!
                      .map((e) => S2Choice(
                          value: e, title: e.countryName, meta: e.thumbnail))
                      .toList();

                  return AppMultiSelectorWithImage(
                      onModalClose: (p0, p1) =>
                          _conversationBloc.add(const SearchConversations('')),
                      selectedValue: _conversationBloc.listLanguage,
                      selectedChoice: _conversationBloc.listLanguage
                          .map((e) => S2Choice(value: e, title: e.language))
                          .toList(),
                      list: list,
                      title: 'Dil',
                      tile: ValueListenableBuilder(
                          valueListenable: _notifierLanguage,
                          builder: (context, value, child) {
                            return _buildRichText(
                                filter: 'Dil:', contents: value);
                          }),
                      onChanged: (value) {
                        _conversationBloc.listLanguage = value.value;
                        var list = value.value.map((e) => e.language).toList();
                        var string = 'All';

                        if (list.length > 2) {
                          string =
                              '${list.getRange(0, 2).join(', ')} +${list.length - 2}';
                        } else if (list.isNotEmpty) {
                          string = list.join(',');
                        }
                        _notifierLanguage.value = string;
                      });
                }
                return _buildRichText(filter: 'Dil:', contents: 'All');
              },
            ),
          ),
          Expanded(
            child: AppMultiSelectorWithIcon(
                onModalClose: (p0, p1) {
                  _conversationBloc.add(const SearchConversations(''));
                },
                selectedChoice: _conversationBloc.listTranslatorStatus
                    .map((e) => S2Choice(value: e, title: e.value))
                    .toList(),
                selectedValue: _conversationBloc.listTranslatorStatus,
                list: _listTranslatorStatus,
                title: 'Durum',
                tile: ValueListenableBuilder(
                    valueListenable: _notifierStatus,
                    builder: (context, value, child) {
                      return _buildRichText(filter: 'Durum:', contents: value);
                    }),
                onChanged: (value) {
                  _conversationBloc.listTranslatorStatus = value.value;
                  if (value.value.isNotEmpty) {
                    _notifierStatus.value =
                        value.value.map((e) => e.value).join(', ');
                  } else {
                    _notifierStatus.value = 'All';
                  }
                }),
          ),
          Expanded(
            child: AppMultiSelectorWithIcon(
                onModalClose: (p0, p1) {
                  _conversationBloc.add(const SearchConversations(''));
                },
                selectedChoice: _conversationBloc.listAvaibleConversationList
                    .map((e) => S2Choice(value: e, title: e.value))
                    .toList(),
                selectedValue: _conversationBloc.listAvaibleConversationList,
                list: _listConversationType,
                title: 'İletişim',
                tile: ValueListenableBuilder(
                    valueListenable: _notifierConversation,
                    builder: (context, value, child) {
                      return _buildRichText(
                          filter: 'İletişim:', contents: value);
                    }),
                onChanged: (value) {
                  _conversationBloc.listAvaibleConversationList = value.value;
                  if (value.value.isNotEmpty) {
                    _notifierConversation.value =
                        value.value.map((e) => e.value).join(', ');
                  } else {
                    _notifierConversation.value = 'All';
                  }
                }),
          ),
        ],
      );
  Widget _buildRichText({required String filter, required String contents}) =>
      RichText(
          overflow: TextOverflow.ellipsis,
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
