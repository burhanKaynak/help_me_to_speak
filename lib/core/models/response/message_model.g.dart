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
      json['file_path'] as String?,
      json['is_file'] as bool,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'message': instance.message,
      'sender_id': instance.senderId,
      'file_path': instance.filePath,
      'is_seens': instance.isSeens,
      'is_file': instance.isFile,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
    };
