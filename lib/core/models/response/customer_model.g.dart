// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      email: json['email'] as String?,
      uid: json['uid'] as String?,
      country: _$JsonConverterFromJson<Object, DocumentReference<Object?>>(
          json['country'], const DocumentConverter().fromJson),
      availableChat: json['available_chat'] as bool?,
      availableVideoCall: json['available_video_call'] as bool?,
      languagesOfTranslate: (json['languages_of_translate'] as List<dynamic>?)
          ?.map((e) => const DocumentConverter().fromJson(e as Object))
          .toList(),
      availableVoiceCall: json['available_voice_call'] as bool?,
      supportLanguages: (json['support_languages'] as List<dynamic>?)
          ?.map((e) => const DocumentConverter().fromJson(e as Object))
          .toList(),
      isApproved: json['is_approved'] as bool?,
      nativeLanguages: (json['native_languages'] as List<dynamic>?)
          ?.map((e) => const DocumentConverter().fromJson(e as Object))
          .toList(),
      displayName: json['display_name'] as String?,
      photoUrl: json['photo_url'] as String?,
      phoneNumber: json['phone_number'] as int?,
      type: json['type'] as int?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'display_name': instance.displayName,
      'photo_url': instance.photoUrl,
      'native_languages': instance.nativeLanguages
          ?.map(const DocumentConverter().toJson)
          .toList(),
      'support_languages': instance.supportLanguages
          ?.map(const DocumentConverter().toJson)
          .toList(),
      'languages_of_translate': instance.languagesOfTranslate
          ?.map(const DocumentConverter().toJson)
          .toList(),
      'country': _$JsonConverterToJson<Object, DocumentReference<Object?>>(
          instance.country, const DocumentConverter().toJson),
      'phone_number': instance.phoneNumber,
      'type': instance.type,
      'is_approved': instance.isApproved,
      'available_chat': instance.availableChat,
      'available_video_call': instance.availableVideoCall,
      'available_voice_call': instance.availableVoiceCall,
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
