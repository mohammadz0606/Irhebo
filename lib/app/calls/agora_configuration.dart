import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:irhebo/app/global_imports.dart';
import 'package:permission_handler/permission_handler.dart';

final class AgoraConfiguration {
  /// Singleton class

  AgoraConfiguration._();

  static final AgoraConfiguration _instance = AgoraConfiguration._();

  factory AgoraConfiguration() {
    return _instance;
  }

  late RtcEngine _agoraEngine;

  Future<void> initAgora({
    required String token,
    required String channelName,
    required int userID,
    required Function() onUserAccepted,
    required Function() onUserEndCall,
  }) async {
    if (Platform.isIOS) {
      await Permission.microphone.request();
    } else {
      final micStatus = await Permission.microphone.request();
      if (!micStatus.isGranted) {
        AppSnackBar.openErrorSnackBar(
            message: 'Please enable the microphone permission'.tr);
        return;
      }
    }
    _agoraEngine = createAgoraRtcEngine();
    await _agoraEngine.initialize(
      const RtcEngineContext(appId: '7c133475b17c4fefb2d88c6fd3c0eccf'),
    );

    await _agoraEngine.setClientRole(
        role: ClientRoleType.clientRoleBroadcaster);
    await _agoraEngine.enableAudio();
    await _agoraEngine.enableLocalVideo(false);
    await _agoraEngine.enableLocalAudio(true);
    await _agoraEngine.muteLocalAudioStream(false);
    await _agoraEngine.setEnableSpeakerphone(false);

    _agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          print("Joined channel: ${connection.channelId}");
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          print("User joined: $remoteUid");
          onUserAccepted();
        },
        onError: (err, msg) {
          print("onError: $err///// $msg");
        },
        onUserOffline: (connection, remoteUid, reason) {
          print("User offline: $remoteUid");
          onUserEndCall();
        },
      ),
    );

    await _agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      uid: userID,
      options: const ChannelMediaOptions(),
    );
  }

  void muteMic(bool mute) async {
    await _agoraEngine.muteLocalAudioStream(mute);
  }

  void switchSpeaker(bool enableSpeaker) async {
    await _agoraEngine.setEnableSpeakerphone(enableSpeaker);
  }

  Future<void> leaveCall() async {
    await _agoraEngine.leaveChannel();
    await _agoraEngine.release();
  }
}
