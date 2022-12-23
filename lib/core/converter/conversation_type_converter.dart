import 'package:json_annotation/json_annotation.dart';

import '../enum/conversation_type_enum.dart';

class ConversationTypeConverter
    implements JsonConverter<ConversationType, String> {
  const ConversationTypeConverter();

  @override
  ConversationType fromJson(Object json) {
    switch (json) {
      case 'voice':
        return ConversationType.voiceCall;
      case 'video':
        return ConversationType.videoCall;
    }
    return ConversationType.voiceCall;
  }

  @override
  String toJson(ConversationType object) {
    return object.value;
  }
}
