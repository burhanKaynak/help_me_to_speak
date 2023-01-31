import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/response/appointment_model.dart';
import '../../service/database_service.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<GetAppointment>((event, emit) async {
      var result = await _getAppointment(event.translatorId);
      emit(AppointmentLoaded(result));
    });
    on<SetAppointment>((event, emit) async {
      emit(AppointmentInitial());
      var resultSetData = await DatabaseService.instance
          .setAppointment(event.translatorId, event.appointmentDates);

      if (!resultSetData) return;

      var result = await _getAppointment(event.translatorId);
      emit(AppointmentLoaded(result));
    });
  }

  Future<Appointment> _getAppointment(translatorId) async {
    return await DatabaseService.instance.getAppointmens(translatorId);
  }
}
