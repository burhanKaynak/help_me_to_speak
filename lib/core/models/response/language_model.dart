import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'language_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Language extends Equatable {
  final String? callingCode, countryName, isoCode, language, thumbnail, docId;

  const Language(
      {required this.callingCode,
      required this.docId,
      required this.countryName,
      required this.isoCode,
      required this.language,
      required this.thumbnail});

  factory Language.fromJson(Map<String, dynamic> json) =>
      _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  @override
  List<Object?> get props =>
      [callingCode, countryName, isoCode, language, thumbnail, docId];
}
