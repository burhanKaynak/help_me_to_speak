// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Call _$CallFromJson(Map<String, dynamic> json) => Call(
      json['sender_id'] as String,
      const CallStateConverter().fromJson(json['state'] as String),
      _$JsonConverterFromJson<Object, DateTime>(
          json['call_started'], const TimestampConverter().fromJson),
      _$JsonConverterFromJson<Object, DateTime>(
          json['call_ended'], const TimestampConverter().fromJson),
      json['doc_id'] as String?,
    );

Map<String, dynamic> _$CallToJson(Call instance) => <String, dynamic>{
      'sender_id': instance.senderId,
      'doc_id': instance.docId,
      'state': const CallStateConverter().toJson(instance.state),
      'call_started': _$JsonConverterToJson<Object, DateTime>(
          instance.callStarted, const TimestampConverter().toJson),
      'call_ended': _$JsonConverterToJson<Object, DateTime>(
          instance.callEnded, const TimestampConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
