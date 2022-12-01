import 'package:help_me_to_speak/core/converter/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rezervation_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Rezervation {
  @TimestampConverter()
  List<DateTime>? busyDate;
  @TimestampConverter()
  List<DateTime>? rezervationDate;

  Rezervation({this.busyDate, this.rezervationDate});

  factory Rezervation.fromJson(Map<String, dynamic> json) =>
      _$RezervationFromJson(json);
  Map<String, dynamic> toJson() => _$RezervationToJson(this);
}
