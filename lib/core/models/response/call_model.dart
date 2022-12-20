import 'package:json_annotation/json_annotation.dart';

import '../../converter/call_state_converter.dart';
import '../../converter/timestamp_converter.dart';
import '../../enum/call_state_enum.dart';

part 'call_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Call {
  String senderId;
  String? docId;

  @CallStateConverter()
  final CallState state;
  @TimestampConverter()
  final DateTime? callStarted, callEnded;

  Call(this.senderId, this.state, this.callStarted, this.callEnded, this.docId);

  factory Call.fromJson(Map<String, dynamic> json) => _$CallFromJson(json);
  Map<String, dynamic> toJson() => _$CallToJson(this);
}
