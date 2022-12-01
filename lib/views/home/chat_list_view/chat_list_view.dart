import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_me_to_speak/core/bloc/conversation_bloc/conversation_bloc.dart';
import 'package:help_me_to_speak/widgets/app_card.dart';

import '../../../core/const/app_padding.dart';
import '../../../core/const/app_sizer.dart';
import '../../../core/const/app_spacer.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../themes/project_themes.dart';
import '../../../widgets/app_divider.dart';
import '../../../widgets/app_search_field.dart';

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
          child: BlocProvider<ConversationBloc>(
            create: (context) => ConversationBloc()..add(GetConversations()),
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
                                userId: e.customer.uid!,
                              )),
                          child: AppCard(chat: e)))
                      .toList(),
                );
              }
              return Container();
            },
          );

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
