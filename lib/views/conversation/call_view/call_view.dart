import 'package:flutter/material.dart';

import '../../../core/enum/call_type_enum.dart';
import '../../../core/enum/conversation_type_enum.dart';
import '../../../core/models/response/call_model.dart';
import '../../../core/models/response/customer_model.dart';
import '../../../themes/project_themes.dart';
import 'video_call_view/video_call_view.dart';
import 'voice_call_view/voice_call_view.dart';

class CallView extends StatelessWidget {
  final ConversationType conversationType;
  final CallType callType;
  final String conversationId;
  final Customer customer;
  final Call call;
  const CallView({
    super.key,
    required this.conversationId,
    required this.callType,
    required this.customer,
    required this.call,
    required this.conversationType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorDarkGreen,
        body: conversationType == ConversationType.voiceCall
            ? VoiceCallView(
                conversationId: conversationId,
                customer: customer,
                call: call,
                callType: callType)
            : VideoCallView(
                conversationId: conversationId,
                customer: customer,
                call: call,
                callType: callType));
  }
}
