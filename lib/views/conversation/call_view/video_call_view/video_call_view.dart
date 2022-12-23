import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../../core/const/app_agora_api_const.dart';
import '../../../../core/const/app_common_const.dart';
import '../../../../core/const/app_padding.dart';
import '../../../../core/const/app_radius.dart';
import '../../../../core/const/app_sizer.dart';
import '../../../../core/const/app_spacer.dart';
import '../../../../core/enum/call_state_enum.dart';
import '../../../../core/enum/call_type_enum.dart';
import '../../../../core/models/response/call_model.dart';
import '../../../../core/models/response/customer_model.dart';
import '../../../../core/service/database_service.dart';
import '../../../../themes/project_themes.dart';
import '../../../../widgets/app_circle_avatar.dart';

class VideoCallView extends StatefulWidget {
  final String conversationId;
  final Customer customer;
  final Call call;
  final CallType callType;

  const VideoCallView(
      {super.key,
      required this.conversationId,
      required this.customer,
      required this.call,
      required this.callType});

  @override
  State<VideoCallView> createState() => _VideoCallViewState();
}

class _VideoCallViewState extends State<VideoCallView> {
  late final Customer _customer = widget.customer;
  late final Call _call = widget.call;
  late final RtcEngine _rtcEngine;

  final ValueNotifier<bool> _isReadyPreview = ValueNotifier(false);
  final ValueNotifier<int> _remoteUserId = ValueNotifier(0);

  final ValueNotifier<bool> _microphoneMute = ValueNotifier(false);
  final ValueNotifier<bool> _cameraUnvisible = ValueNotifier(false);
  final ValueNotifier<bool> _switchCamera = ValueNotifier(false);

  final ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;

  final StopWatchTimer _watchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp);

  @override
  void initState() {
    initAgora();
    super.initState();
  }

  void initAgora() async {
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
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        _remoteUserId.value = rUid;
        print('[onUserJoined] connection: ${connection.toJson()} $rUid');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        print(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
      },
    ));
    await _rtcEngine.enableVideo();
    await _rtcEngine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        frameRate: 15,
        bitrate: 0,
      ),
    );

    await _rtcEngine.startPreview();
    _isReadyPreview.value = true;
    _joinChannel();
  }

  @override
  void dispose() async {
    super.dispose();
    _watchTimer.dispose();
    await _dispose();
  }

  Future<void> _dispose() async {
    await _rtcEngine.leaveChannel();
    await _rtcEngine.release();
  }

  @override
  Widget build(BuildContext context) {
    return _streamBuilder;
  }

  Future<void> _joinChannel() async {
    await _rtcEngine.joinChannel(
      token: AgoraApiConst.token,
      channelId: 'channel',
      uid: 0,
      options: ChannelMediaOptions(
        channelProfile: _channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  StreamBuilder<DocumentSnapshot> get _streamBuilder =>
      StreamBuilder<DocumentSnapshot>(
        stream: DatabaseService.instance.listenCalling(_call.docId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!.data() as Map<String, dynamic>;
            Call call = Call.fromJson(data);
            if (call.state == CallState.answered) {
              return _buildVideoView;
            } else if (call.state == CallState.rejected) {
              context.router.pop();
            } else {
              return _buildCallView;
            }
          }
          return _buildCallView;
        },
      );

  Widget get _buildVideoView => Stack(
        children: [
          ValueListenableBuilder(
              valueListenable: _isReadyPreview,
              builder: (context, value, child) => value
                  ? Column(
                      children: [
                        Expanded(
                          child: AgoraVideoView(
                              controller: VideoViewController(
                                  canvas: const VideoCanvas(uid: 0),
                                  useAndroidSurfaceView: false,
                                  useFlutterTexture: false,
                                  rtcEngine: _rtcEngine)),
                        ),
                        Expanded(
                          child: ValueListenableBuilder(
                            valueListenable: _remoteUserId,
                            builder: (context, value, child) => value != 0
                                ? AgoraVideoView(
                                    controller: VideoViewController.remote(
                                    rtcEngine: _rtcEngine,
                                    canvas: VideoCanvas(uid: value),
                                    connection: const RtcConnection(
                                        channelId: 'channel'),
                                    useFlutterTexture: false,
                                    useAndroidSurfaceView: false,
                                  ))
                                : const SizedBox.shrink(),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink()),
          Container(
            margin: AppPadding.layoutPadding,
            alignment: Alignment.bottomCenter,
            child: _buildVideoFooter(_call),
          ),
        ],
      );

  Widget _buildVideoFooter(Call call) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildCircleIconButton(FontAwesomeIcons.rotate, () async {
            _rtcEngine.switchCamera();
            _switchCamera.value = !_switchCamera.value;
          }),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: const CircleBorder(),
                  padding: AppPadding.layoutPadding),
              onPressed: () => DatabaseService.instance.endCall(_call.docId),
              child: const FaIcon(
                FontAwesomeIcons.xmark,
                size: 25,
              )),
          ValueListenableBuilder(
              valueListenable: _microphoneMute,
              builder: (context, value, child) => _buildCircleIconButton(
                    !value
                        ? FontAwesomeIcons.microphone
                        : FontAwesomeIcons.microphoneSlash,
                    () async {
                      _microphoneMute.value = !_microphoneMute.value;
                      await _rtcEngine
                          .muteLocalAudioStream(_microphoneMute.value);
                    },
                  )),
          ValueListenableBuilder(
              valueListenable: _cameraUnvisible,
              builder: (context, value, child) => _buildCircleIconButton(
                    !value
                        ? FontAwesomeIcons.video
                        : FontAwesomeIcons.videoSlash,
                    () async {
                      await _rtcEngine.enableLocalVideo(_cameraUnvisible.value);
                      _cameraUnvisible.value = !_cameraUnvisible.value;
                    },
                  )),
        ],
      );

  Widget _buildCircleIconButton(IconData icon, VoidCallback onPressed) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), padding: AppPadding.inputPadding),
        onPressed: onPressed,
        child: FaIcon(
          icon,
          size: 15,
        ));
  }

  Widget get _buildCallView => SafeArea(
        child: Padding(
          padding: AppPadding.layoutPadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCallHeader(widget.callType.value),
              _buildCallFooter(_call)
            ],
          ),
        ),
      );

  Widget _buildCallFooter(Call call) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              DatabaseService.instance.endCall(_call.docId);
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
          if (widget.callType == CallType.callee &&
              call.state != CallState.answered)
            InkWell(
              onTap: () {
                DatabaseService().answerCall(_call.docId);
              },
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

  Widget _buildCallHeader(
    String title,
  ) =>
      Column(
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
}
