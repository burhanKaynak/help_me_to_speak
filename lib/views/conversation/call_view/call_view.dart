import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../core/const/app_agora_api_const.dart';
import '../../../core/const/app_common_const.dart';
import '../../../core/const/app_padding.dart';
import '../../../core/const/app_radius.dart';
import '../../../core/const/app_sizer.dart';
import '../../../core/const/app_spacer.dart';
import '../../../core/enum/call_state_enum.dart';
import '../../../core/models/response/call_model.dart';
import '../../../core/models/response/customer_model.dart';
import '../../../core/service/database_service.dart';
import '../../../themes/project_themes.dart';
import '../../../widgets/app_circle_avatar.dart';

class CallView extends StatefulWidget {
  final int type;
  final String conversationId;
  final Customer customer;
  final Call call;
  const CallView({
    super.key,
    required this.conversationId,
    required this.type,
    required this.customer,
    required this.call,
  });

  @override
  State<CallView> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  late final Customer _customer = widget.customer;
  late final RtcEngine _rtcEngine;
  final StopWatchTimer _watchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp);

  @override
  void initState() {
    initAgoraEngine();
    super.initState();
  }

  void initAgoraEngine() async {
    _rtcEngine = createAgoraRtcEngine();
    await _rtcEngine
        .initialize(const RtcEngineContext(appId: AgoraApiConst.appId));
    _rtcEngine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        print('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        print(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
      },
    ));

    await _rtcEngine.enableAudio();
    await _rtcEngine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _rtcEngine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
  }

  @override
  void dispose() async {
    _watchTimer.dispose();
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    await _rtcEngine.leaveChannel();
    await _rtcEngine.release();
  }

  @override
  Widget build(BuildContext context) {
    var paddingTop = MediaQuery.of(context).padding.top * 2;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          backgroundColor: colorDarkGreen,
          body: Padding(
            padding: AppPadding.layoutPadding.copyWith(top: paddingTop),
            child: StreamBuilder<DocumentSnapshot>(
              stream: DatabaseService.instance.listenCalling(widget.call.docId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.data() as Map<String, dynamic>;
                  Call call = Call.fromJson(data);
                  if (call.state == CallState.answered) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeader('Şu an aramada'),
                        _buildBody(call.state),
                        _buildFooter(call)
                      ],
                    );
                  }
                  if (call.state == CallState.rejected) {
                    context.router.pop();
                  }
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHeader(widget.type == 1 ? 'Arıyor' : 'Aranıyor'),
                    _buildBody(CallState.calling),
                    _buildFooter(widget.call)
                  ],
                );
              },
            ),
          )),
    );
  }

  Widget _buildHeader(String title) => Column(
        children: [
          AppListCircleAvatar(
              url: _customer.photoUrl ?? CommonConst.defAvatar,
              isOnline: true,
              langs: null),
          AppSpacer.verticalSmallSpace,
          Text(
            _customer.displayName!,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          AppSpacer.verticalSmallSpace,
          Text(
            title,
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      );
  Widget _buildBody(CallState callState) {
    return StreamBuilder<int>(
      stream: _watchTimer.rawTime,
      initialData: 0,
      builder: (context, snapshot) {
        if (callState == CallState.answered) {
          _watchTimer.onStartTimer();
          final value = snapshot.data;
          final displayTime = StopWatchTimer.getDisplayTime(value!,
              milliSecond: false, second: true);
          return Column(
            children: [
              Text(
                'Geçen Süre:',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                displayTime,
                style: Theme.of(context).textTheme.headline4,
              ),
              AppSpacer.verticalLargeSpace,
              Text(
                'Toplam Ücret:',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                '0 KR',
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          );
        }
        return Column(
          children: [
            Text(
              'Geçen Süre:',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '00:00:00',
              style: Theme.of(context).textTheme.headline4,
            ),
            AppSpacer.verticalLargeSpace,
            Text(
              'Toplam Ücret:',
              style: Theme.of(context).textTheme.headline6,
            ),
            Text(
              '0 KR',
              style: Theme.of(context).textTheme.headline4,
            )
          ],
        );
      },
    );
  }

  Widget _buildFooter(Call call) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async {
              DatabaseService.instance.endCall(widget.call.docId);
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              width: AppSizer.circleLarge + AppSizer.circleMedium,
              height: AppSizer.circleLarge + AppSizer.circleMedium,
              decoration: BoxDecoration(
                  borderRadius: AppRadius.circleRadius, color: colorPrimary),
              child: FaIcon(
                FontAwesomeIcons.xmark,
                color: Colors.white,
                size: AppSizer.iconLarge,
              ),
            ),
          ),
          if (widget.type == 1 && call.state != CallState.answered)
            InkWell(
              onTap: () => DatabaseService().answerCall(widget.call.docId),
              child: Container(
                alignment: Alignment.center,
                width: AppSizer.circleLarge + AppSizer.circleMedium,
                height: AppSizer.circleLarge + AppSizer.circleMedium,
                decoration: BoxDecoration(
                    borderRadius: AppRadius.circleRadius,
                    color: colorLightGreen),
                child: FaIcon(
                  FontAwesomeIcons.phone,
                  color: Colors.white,
                  size: AppSizer.iconLarge,
                ),
              ),
            )
        ],
      );
}
