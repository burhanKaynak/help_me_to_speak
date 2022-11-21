import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:help_me_to_speak/core/service/database_service.dart';

import '../../../core/bloc/translator_bloc/translator_bloc.dart';
import '../../../core/const/app_padding.dart';
import '../../../core/const/app_sizer.dart';
import '../../../core/const/app_spacer.dart';
import '../../../core/models/response/customer_model.dart';
import '../../../themes/project_themes.dart';
import '../../../widgets/app_circle_avatar.dart';
import '../../../widgets/app_circle_image.dart';
import '../../../widgets/app_search_field.dart';
import '../../../widgets/app_shimmer.dart';
import '../../../widgets/app_silver_grid_delegate_fixed_cross_axis_count_and_fixed_heigth.dart';

//TODO: Hacı burda çok karmaşık kod var bunları düzenle.

class TranslatorListView extends StatefulWidget {
  const TranslatorListView({super.key});

  @override
  State<TranslatorListView> createState() => _TranslatorListViewState();
}

class _TranslatorListViewState extends State<TranslatorListView> {
  ThemeData? _themeData;
  final String _defAvatar =
      'https://www.ktoeos.org/wp-content/uploads/2021/11/default-avatar.png';

  @override
  Widget build(BuildContext context) {
    _themeData = Theme.of(context);
    return BlocProvider(
      create: (context) => TranslatorBloc()..add(GetTranslators()),
      child: Padding(
        padding: AppPadding.horizontalPaddingMedium,
        child: Column(
          children: [
            AppSearchBarField(),
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
                url: item.photoUrl ?? _defAvatar,
                isOnline: true,
                langs: FutureBuilder(
                  future: DatabaseService.instance
                      .getTranslatorSupportLanguages(translators[index].uid),
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
          style: _themeData!.textTheme.headline6!
              .copyWith(color: colorDarkGreen, overflow: TextOverflow.ellipsis),
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
