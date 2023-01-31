part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final Appointment data;
  const AppointmentLoaded(this.data);
}

class AppointmentError extends AppointmentState {
  final String errorMessage;
  const AppointmentError(this.errorMessage);
}
