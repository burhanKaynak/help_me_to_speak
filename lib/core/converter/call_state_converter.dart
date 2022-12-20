import 'package:json_annotation/json_annotation.dart';

import '../enum/call_state_enum.dart';

class CallStateConverter implements JsonConverter<CallState, String> {
  const CallStateConverter();

  @override
  CallState fromJson(Object json) {
    switch (json) {
      case 'calling':
        return CallState.calling;
      case 'answered':
        return CallState.answered;
      case 'rejected':
        return CallState.rejected;
    }
    return CallState.calling;
  }

  @override
  String toJson(CallState object) {
    return object.value;
  }
}
