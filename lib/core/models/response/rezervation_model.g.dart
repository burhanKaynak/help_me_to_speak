// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rezervation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Rezervation _$RezervationFromJson(Map<String, dynamic> json) => Rezervation(
      busyDate: (json['busy_date'] as List<dynamic>?)
          ?.map((e) => const TimestampConverter().fromJson(e as Object))
          .toList(),
      rezervationDate: (json['rezervation_date'] as List<dynamic>?)
          ?.map((e) => const TimestampConverter().fromJson(e as Object))
          .toList(),
    );

Map<String, dynamic> _$RezervationToJson(Rezervation instance) =>
    <String, dynamic>{
      'busy_date':
          instance.busyDate?.map(const TimestampConverter().toJson).toList(),
      'rezervation_date': instance.rezervationDate
          ?.map(const TimestampConverter().toJson)
          .toList(),
    };
