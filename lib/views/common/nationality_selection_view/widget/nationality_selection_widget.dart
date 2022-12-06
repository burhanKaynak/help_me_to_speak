import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/const/app_padding.dart';
import '../../../../core/const/app_sizer.dart';
import '../../../../core/const/app_spacer.dart';
import '../../../../core/models/response/language_model.dart';
import '../../../../themes/project_themes.dart';
import '../../../../widgets/app_circle_image.dart';
import '../../../../widgets/app_divider.dart';
import '../../../../widgets/app_search_field.dart';

Widget buildListHeader(context,
    {required String title,
    Function(String)? onChanged,
    required String description,
    required String searchBarHint}) {
  return Padding(
    padding: AppPadding.layoutPadding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: colorDarkGreen, fontWeight: FontWeight.bold),
        ),
        Text(
          description,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(color: Colors.black38),
        ),
        AppSpacer.verticalMediumSpace,
        AppSearchBarField(
          onChanged: onChanged,
          hint: searchBarHint,
        ),
      ],
    ),
  );
}

Widget buildListTile(
    List<Language> data,
    ValueNotifier<List<Language>> selectedItems,
    Function(bool?, Language item) onChanged) {
  return Column(
    children: [
      Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: AppPadding.horizontalPaddingMedium,
                  child: ValueListenableBuilder(
                    valueListenable: selectedItems,
                    builder: (context, value, child) => CheckboxListTile(
                      value: selectedItems.value
                          .any((e) => e.docId == data[index].docId),
                      onChanged: (value) => onChanged(value, data[index]),
                      title: Row(
                        children: [
                          AppCircleImage(image: data[index].thumbnail!),
                          AppSpacer.horizontalMediumSpace,
                          Text(
                            data[index].countryName!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(color: Colors.black54),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                AppDivider(
                    height: AppSizer.dividerH,
                    tickness: AppSizer.dividerTicknessSmall)
              ],
            );
          },
          itemCount: data.length,
        ),
      ),
      const Align(
          alignment: Alignment.topCenter,
          child: FaIcon(FontAwesomeIcons.chevronDown))
    ],
  );
}
