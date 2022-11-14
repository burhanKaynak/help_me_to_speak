// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      callingCode: json['calling_code'] as String?,
      countryName: json['country_name'] as String?,
      isoCode: json['iso_code'] as String?,
      language: json['language'] as String?,
      thumbnail: json['thumbnail'] as String?,
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'calling_code': instance.callingCode,
      'country_name': instance.countryName,
      'iso_code': instance.isoCode,
      'language': instance.language,
      'thumbnail': instance.thumbnail,
    };
