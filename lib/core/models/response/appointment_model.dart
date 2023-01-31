import 'package:json_annotation/json_annotation.dart';

import '../../converter/timestamp_converter.dart';

part 'appointment_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Appointment {
  @TimestampConverter()
  List<DateTime>? busyDate;
  @TimestampConverter()
  List<DateTime>? appointmentDate;

  Appointment({this.busyDate, this.appointmentDate});

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);
  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
