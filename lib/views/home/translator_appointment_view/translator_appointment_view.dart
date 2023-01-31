import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../core/bloc/appointment_bloc/appointment_bloc.dart';
import '../../../core/const/app_padding.dart';
import '../../../core/const/app_sizer.dart';
import '../../../core/models/response/appointment_model.dart';
import '../../../themes/project_themes.dart';
import '../../../widgets/app_divider.dart';
import '../../../widgets/app_header.dart';

class TranslatorAppointmentView extends StatelessWidget {
  final String translatorId;
  const TranslatorAppointmentView({super.key, required this.translatorId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        title: 'Randevu Al',
        backButton: true,
      ),
      body: BlocProvider(
        create: (context) =>
            AppointmentBloc()..add(GetAppointment(translatorId)),
        child: TranslatorAppointmentViewController(translatorId: translatorId),
      ),
    );
  }
}

class TranslatorAppointmentViewController extends StatefulWidget {
  final String translatorId;
  const TranslatorAppointmentViewController(
      {super.key, required this.translatorId});

  @override
  State<TranslatorAppointmentViewController> createState() =>
      _TranslatorAppointmentViewControllerState();
}

class _TranslatorAppointmentViewControllerState
    extends State<TranslatorAppointmentViewController> {
  final DateRangePickerController _dateRangePickerController =
      DateRangePickerController();

  @override
  void initState() {
    _dateRangePickerController.selectedDates = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppDivider(
            height: AppSizer.dividerH, tickness: AppSizer.dividerTicknessSmall),
        Expanded(
          child: Padding(
              padding: AppPadding.layoutPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Tarihi Seçin',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: colorDarkGreen, fontWeight: FontWeight.w400),
                  ),
                  const Spacer(),
                  Expanded(flex: 7, child: _appointmentBlocBuilder()),
                  Expanded(child: _buildFooter)
                ],
              )),
        ),
      ],
    );
  }

  BlocBuilder<AppointmentBloc, AppointmentState> _appointmentBlocBuilder() {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        if (state is AppointmentLoaded) {
          _dateRangePickerController.selectedDates = [];
          return _buildCalendar(state.data);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildCalendar(Appointment data) => SfDateRangePicker(
        selectionMode: DateRangePickerSelectionMode.multiple,
        endRangeSelectionColor: colorLightGreen,
        controller: _dateRangePickerController,
        startRangeSelectionColor: colorLightGreen,
        selectionColor: colorLightGreen,
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
        selectableDayPredicate: (dateTime) {
          var busyDate = data.busyDate!.firstWhereOrNull((e) =>
              e.year == dateTime.year &&
              e.month == dateTime.month &&
              e.day == dateTime.day);

          var appointmentDate = data.appointmentDate!.firstWhereOrNull((e) =>
              e.year == dateTime.year &&
              e.month == dateTime.month &&
              e.day == dateTime.day);

          return (busyDate == null && appointmentDate == null) ? true : false;
        },
        headerStyle: DateRangePickerHeaderStyle(
            textStyle: Theme.of(context).textTheme.headline6,
            backgroundColor: colorLightGreen,
            textAlign: TextAlign.center),
        allowViewNavigation: true,
      );

  Widget get _buildFooter => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Container(
                  height: AppSizer.circleSmall,
                  width: AppSizer.circleSmall,
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
                  height: AppSizer.circleSmall,
                  width: AppSizer.circleSmall,
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
              onPressed: () {
                if (_dateRangePickerController.selectedDates!.isNotEmpty) {
                  context.read<AppointmentBloc>().add(SetAppointment(
                      widget.translatorId,
                      _dateRangePickerController.selectedDates!));
                }
              },
              child: Row(
                children: [
                  const Text('Kaydet'),
                  FaIcon(
                    FontAwesomeIcons.chevronRight,
                    size: AppSizer.iconSmall,
                  )
                ],
              )),
        ],
      );
}
