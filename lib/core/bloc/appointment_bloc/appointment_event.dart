part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class GetAppointment extends AppointmentEvent {
  final String translatorId;
  const GetAppointment(this.translatorId);
}

class SetAppointment extends AppointmentEvent {
  final String translatorId;
  final List<DateTime> appointmentDates;
  const SetAppointment(this.translatorId, this.appointmentDates);
}
