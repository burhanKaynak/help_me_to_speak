import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/const/app_padding.dart';
import '../core/const/app_spacer.dart';
import '../themes/project_themes.dart';
import 'app_buttons.dart';
import 'app_circle_image.dart';

class AppMultiSelectorWithIcon<T> extends StatelessWidget {
  final List<S2Choice<T>> list;
  final List<T> selectedValue;
  final List<S2Choice<T>> selectedChoice;
  final String title;
  final Widget tile;
  final Function(S2MultiSelected<T> value) onChanged;

  const AppMultiSelectorWithIcon(
      {super.key,
      required this.selectedValue,
      required this.list,
      required this.title,
      required this.tile,
      required this.onChanged,
      required this.selectedChoice});

  @override
  Widget build(BuildContext context) {
    return SmartSelect<T>.multiple(
      selectedValue: selectedValue,
      selectedChoice: selectedChoice,
      title: title,
      choiceItems: list,
      modalConfirm: true,
      modalType: S2ModalType.bottomSheet,
      onChange: onChanged,
      tileBuilder: (context, value) {
        return InkWell(onTap: value.showModal, child: tile);
      },
      modalHeaderBuilder: (context, value) => Padding(
        padding: AppPadding.layoutPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.title!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.black)),
            IconButton(
                onPressed: () => value.closeModal(),
                icon: const FaIcon(FontAwesomeIcons.xmark))
          ],
        ),
      ),
      choiceTitleBuilder: (context, value, anotherValue) => Row(
        children: [
          FaIcon(
            anotherValue.meta,
            color: colorLightGreen,
          ),
          AppSpacer.horizontalMediumSpace,
          Text(
            anotherValue.title!,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.black.withOpacity(0.6)),
          )
        ],
      ),
      modalFooterBuilder: (context, value) => Padding(
          padding: AppPadding.horizontalPaddingMedium,
          child: buildButton(onPressed: () => null, text: 'Kaydet')),
    );
  }
}

class AppMultiSelectorWithImage<T> extends StatelessWidget {
  final List<S2Choice<T>> list;
  final List<S2Choice<T>> selectedChoice;
  final List<T> selectedValue;

  final String title;
  final Widget tile;
  final Function(S2MultiSelected<T> value) onChanged;

  const AppMultiSelectorWithImage(
      {super.key,
      required this.list,
      required this.title,
      required this.tile,
      required this.onChanged,
      required this.selectedChoice,
      required this.selectedValue});

  @override
  Widget build(BuildContext context) {
    return SmartSelect<T>.multiple(
      title: title,
      choiceItems: list,
      selectedChoice: selectedChoice,
      selectedValue: selectedValue,
      modalConfirm: true,
      modalType: S2ModalType.bottomSheet,
      onChange: onChanged,
      tileBuilder: (context, value) {
        return InkWell(onTap: value.showModal, child: tile);
      },
      modalHeaderBuilder: (context, value) => Padding(
        padding: AppPadding.layoutPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.title!,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Colors.black)),
            IconButton(
                onPressed: () => value.closeModal(),
                icon: const FaIcon(FontAwesomeIcons.xmark))
          ],
        ),
      ),
      choiceTitleBuilder: (context, value, anotherValue) => Row(
        children: [
          AppCircleImage(image: anotherValue.meta),
          AppSpacer.horizontalMediumSpace,
          Text(
            anotherValue.title!,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.black.withOpacity(0.6)),
          )
        ],
      ),
      modalFooterBuilder: (context, value) => Padding(
          padding: AppPadding.horizontalPaddingMedium,
          child: buildButton(onPressed: () => null, text: 'Kaydet')),
    );
  }
}
