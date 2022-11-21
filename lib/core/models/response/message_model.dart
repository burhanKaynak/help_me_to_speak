import 'package:json_annotation/json_annotation.dart';

import '../../converter/timestamp_converter.dart';

part 'message_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Message {
  final String message, senderId;
  final bool isSeens;

  @TimestampConverter()
  final String timestamp;
  Message(this.message, this.timestamp, this.isSeens, this.senderId);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
