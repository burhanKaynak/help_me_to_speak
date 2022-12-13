import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/bloc/translator_bloc/translator_bloc.dart';
import '../../../core/const/app_common_const.dart';
import '../../../core/const/app_padding.dart';
import '../../../core/const/app_sizer.dart';
import '../../../core/const/app_spacer.dart';
import '../../../core/enum/available_conversation_type_enum.dart';
import '../../../core/enum/translator_status_enum.dart';
import '../../../core/models/response/customer_model.dart';
import '../../../core/models/response/language_model.dart';
import '../../../core/service/database_service.dart';
import '../../../themes/project_themes.dart';
import '../../../widgets/app_circle_avatar.dart';
import '../../../widgets/app_circle_image.dart';
import '../../../widgets/app_search_field.dart';
import '../../../widgets/app_selector.dart';
import '../../../widgets/app_shimmer.dart';
import '../../../widgets/app_silver_grid_delegate_fixed_cross_axis_count_and_fixed_heigth.dart';

class TranslatorListView extends StatefulWidget {
  const TranslatorListView({super.key});

  @override
  State<TranslatorListView> createState() => _TranslatorListViewState();
}

class _TranslatorListViewState extends State<TranslatorListView> {
  final TranslatorBloc _translatorBloc = TranslatorBloc()
    ..add(GetTranslators());
  ThemeData? _themeData;

  final ValueNotifier<String> _notifierLanguage = ValueNotifier('All'),
      _notifierStatus = ValueNotifier('All'),
      _notifierConversation = ValueNotifier('All');

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return BlocProvider(
      create: (context) => _translatorBloc,
      child: Padding(
        padding: AppPadding.horizontalPaddingMedium,
        child: Column(
          children: [
            AppSearchBarField(
              hint: 'Bir tercüman arayın',
              onChanged: (val) => _translatorBloc.add(SearchTranslators(val)),
            ),
            AppSpacer.verticalLargeSpace,
            _buildFilterBar,
            AppSpacer.verticalLargeSpace,
            Expanded(child: _translatorBlocBuilder())
          ],
        ),
      ),
    );
  }

  BlocBuilder<TranslatorBloc, TranslatorState> _translatorBlocBuilder() =>
      BlocBuilder<TranslatorBloc, TranslatorState>(
        buildWhen: (previous, current) => true,
        builder: (context, state) {
          if (state is TranslatorInitial) {
          } else if (state is TranslatorLoaded) {
            return _buildTranslatorList(state.translators);
          } else if (state is TranslatorError) {}
          return const SizedBox.shrink();
        },
      );

  Widget _buildTranslatorList(List<Customer> translators) => GridView.builder(
        itemCount: translators.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
            crossAxisCount: 3,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
            height: AppSizer.gridSmall),
        itemBuilder: (context, index) {
          var item = translators[index];
          return Column(
            children: [
              AppListCircleAvatar(
                translatorId: item.uid,
                url: item.photoUrl ?? CommonConst.defAvatar,
                isOnline: true,
                langs: FutureBuilder(
                  future: DatabaseService.instance
                      .getTranslatorSupportLanguagesByRef(
                    translators[index].languagesOfTranslate!,
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Wrap(
                        spacing: 5,
                        children: snapshot.data!
                            .map((e) => AppCircleImage(image: e.thumbnail!))
                            .toList(),
                      );
                    }
                    return buildCircleShimmer;
                  },
                ),
                showAddRemoveButton: true,
                hasChat: false,
              ),
              AppSpacer.verticalSmallSpace,
              _buildNameAndState(fullName: item.displayName!, isOnline: true)
            ],
          );
        },
      );

  Widget _buildNameAndState(
      {required String fullName, required bool isOnline}) {
    return Wrap(
      direction: Axis.horizontal,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 5,
      children: [
        Text(
          fullName,
          style: _themeData!.textTheme.headline5!
              .copyWith(fontWeight: FontWeight.w500)
              .copyWith(color: colorDarkGreen, overflow: TextOverflow.ellipsis),
        ),
        Text(isOnline ? 'Şu an Çeviriye Hazır' : 'Çevirimdışı',
            style: _themeData!.textTheme.caption!
                .copyWith(color: isOnline ? colorLightGreen : colorHint)),
      ],
    );
  }

  final List<S2Choice<AvaibleConversationType>> _listConversationType = [
    S2Choice<AvaibleConversationType>(
        meta: FontAwesomeIcons.solidMessage,
        title: AvaibleConversationType.chat.value,
        value: AvaibleConversationType.chat),
    S2Choice<AvaibleConversationType>(
        meta: FontAwesomeIcons.video,
        title: AvaibleConversationType.videoCall.value,
        value: AvaibleConversationType.videoCall),
    S2Choice<AvaibleConversationType>(
        meta: FontAwesomeIcons.phone,
        title: AvaibleConversationType.voiceCall.value,
        value: AvaibleConversationType.voiceCall),
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
                          _translatorBloc.add(const SearchTranslators('')),
                      selectedValue: _translatorBloc.listLanguage,
                      selectedChoice: _translatorBloc.listLanguage
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
                        _translatorBloc.listLanguage = value.value;
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
                  _translatorBloc.add(const SearchTranslators(''));
                },
                selectedChoice: _translatorBloc.listTranslatorStatus
                    .map((e) => S2Choice(value: e, title: e.value))
                    .toList(),
                selectedValue: _translatorBloc.listTranslatorStatus,
                list: _listTranslatorStatus,
                title: 'Durum',
                tile: ValueListenableBuilder(
                    valueListenable: _notifierStatus,
                    builder: (context, value, child) {
                      return _buildRichText(filter: 'Durum:', contents: value);
                    }),
                onChanged: (value) {
                  _translatorBloc.listTranslatorStatus = value.value;
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
                  _translatorBloc.add(const SearchTranslators(''));
                },
                selectedChoice: _translatorBloc.listAvaibleConversationList
                    .map((e) => S2Choice(value: e, title: e.value))
                    .toList(),
                selectedValue: _translatorBloc.listAvaibleConversationList,
                list: _listConversationType,
                title: 'İletişim',
                tile: ValueListenableBuilder(
                    valueListenable: _notifierConversation,
                    builder: (context, value, child) {
                      return _buildRichText(
                          filter: 'İletişim:', contents: value);
                    }),
                onChanged: (value) {
                  _translatorBloc.listAvaibleConversationList = value.value;
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
