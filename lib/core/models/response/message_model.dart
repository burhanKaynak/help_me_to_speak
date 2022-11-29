import 'package:json_annotation/json_annotation.dart';

import '../../converter/timestamp_converter.dart';

part 'message_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Message {
  final String message, senderId;
  final String? filePath;
  final bool isSeens, isFile;

  @TimestampConverter()
  final DateTime timestamp;
  Message(this.message, this.timestamp, this.isSeens, this.senderId,
      this.filePath, this.isFile);

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
