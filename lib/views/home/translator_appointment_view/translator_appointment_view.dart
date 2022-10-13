import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:help_me_to_speak/themes/project_themes.dart';
import 'package:help_me_to_speak/views/home/chat_list_view/chat_list_view.dart';
import 'package:help_me_to_speak/widgets/app_card.dart';
import 'package:help_me_to_speak/widgets/app_header.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class TranslatorAppointmentView extends StatefulWidget {
  const TranslatorAppointmentView({super.key});

  @override
  State<TranslatorAppointmentView> createState() =>
      _TranslatorAppointmentViewState();
}

class _TranslatorAppointmentViewState extends State<TranslatorAppointmentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        title: 'Randevu Al',
        backButton: true,
      ),
      body: Column(
        children: [
          AppCard(
            topDivider: false,
            chat: Chat(
                fullName: 'Angelina',
                avatar:
                    'https://img.freepik.com/free-photo/modern-woman-taking-selfie_23-2147893976.jpg?w=1380&t=st=1664901155~exp=1664901755~hmac=9127862f43915452a82d24ac02ba9768ff5b63354f3f46bcaf54bbf830d34235',
                isOnline: true,
                lastSeen: 'Pazartesi',
                lastMessage: 'Fotoğraf ulaştı, tercüme ediyorum.'),
          ),
          const Divider(
            height: 0.5,
            thickness: 1.5,
            color: Colors.white,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Tarihi Seçin',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: colorDarkGreen, fontWeight: FontWeight.w400),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //       color: colorLightGreen,
                  //       borderRadius: BorderRadius.circular(10)),
                  //   padding: const EdgeInsets.all(15),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       IconButton(
                  //           onPressed: null,
                  //           icon: FaIcon(
                  //             FontAwesomeIcons.chevronLeft,
                  //             color: Colors.white,
                  //           )),
                  //       Text(
                  //         'Haziran 2022',
                  //         style: Theme.of(context).textTheme.headline6,
                  //       ),
                  //       IconButton(
                  //           onPressed: null,
                  //           icon: FaIcon(
                  //             FontAwesomeIcons.chevronRight,
                  //             color: Colors.white,
                  //           )),
                  //     ],
                  //   ),
                  // ),
                  _buildCalendar,
                  _buildFooter
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get _buildCalendar => SfDateRangePicker(
        endRangeSelectionColor: colorLightGreen,
        startRangeSelectionColor: colorLightGreen,
        rangeSelectionColor: colorLightGreen.withOpacity(0.4),
        selectionTextStyle: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
        rangeTextStyle: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
        monthCellStyle: DateRangePickerMonthCellStyle(
            textStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
            todayTextStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
            disabledDatesTextStyle: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w400),
            todayCellDecoration: const BoxDecoration(shape: BoxShape.rectangle),
            disabledDatesDecoration:
                const BoxDecoration(color: colorHint, shape: BoxShape.circle)),
        enablePastDates: false,
        showTodayButton: false,
        selectableDayPredicate: (date) {
          if (date.day == DateTime.now().day + 2) {
            return false;
          }
          return true;
        },
        headerStyle: DateRangePickerHeaderStyle(
            textStyle: Theme.of(context).textTheme.headline6,
            backgroundColor: colorLightGreen,
            textAlign: TextAlign.center),
        allowViewNavigation: true,
        selectionMode: DateRangePickerSelectionMode.range,
      );

  Widget get _buildFooter => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Container(
                  height: 25,
                  width: 25,
                  color: colorHint,
                ),
              ),
              Text(
                ' Kapalı Günler',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.black54),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Container(
                  height: 25,
                  width: 25,
                  color: colorLightGreen,
                ),
              ),
              Text(
                ' Seçtiğiniz Günler',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.black54),
              )
            ],
          ),
          ElevatedButton(
              onPressed: null,
              child: Row(
                children: const [
                  Text('Devam'),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: 15,
                  )
                ],
              )),
        ],
      );
}
