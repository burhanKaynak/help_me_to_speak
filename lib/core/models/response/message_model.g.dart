// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      json['message'] as String,
      const TimestampConverter().fromJson(json['timestamp'] as Object),
      json['is_seens'] as bool,
      json['sender_id'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'message': instance.message,
      'sender_id': instance.senderId,
      'is_seens': instance.isSeens,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
