// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      busyDate: (json['busy_date'] as List<dynamic>?)
          ?.map((e) => const TimestampConverter().fromJson(e as Object))
          .toList(),
      appointmentDate: (json['appointment_date'] as List<dynamic>?)
          ?.map((e) => const TimestampConverter().fromJson(e as Object))
          .toList(),
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'busy_date':
          instance.busyDate?.map(const TimestampConverter().toJson).toList(),
      'appointment_date': instance.appointmentDate
          ?.map(const TimestampConverter().toJson)
          .toList(),
    };
