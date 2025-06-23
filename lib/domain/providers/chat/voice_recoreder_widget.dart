import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:irhebo/domain/providers/chat/chat_provider.dart';
import 'package:irhebo/domain/providers/chat/voice_recorde_provider.dart';
import 'package:irhebo/presentation/screens/chat/chat_controller.dart';

import '../../../app/global_imports.dart';
import '../../../app/resources/images.dart';
import '../../../presentation/widgets/decorated_icon.dart';
import '../../params/new_params/chat/send_message_param.dart';

class CustomVoiceRecorde extends StatefulWidget {
  const CustomVoiceRecorde({super.key});

  @override
  State<CustomVoiceRecorde> createState() => _CustomVoiceRecordeState();
}

class _CustomVoiceRecordeState extends State<CustomVoiceRecorde> {
  late VoiceRecorderProvider _provider;

  @override
  void initState() {
    _provider = Provider.of<VoiceRecorderProvider>(context, listen: false);
    _provider.initRecorder();

    super.initState();
  }

  @override
  void dispose() {
    _provider.disposeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Consumer<VoiceRecorderProvider>(
      builder: (context, provider, _) {
        return StreamBuilder<RecordingDisposition>(
          stream: provider.recorder.onProgress,
          builder: (context, snapshot) {
            Duration duration =
                snapshot.hasData ? snapshot.data!.duration : Duration.zero;
            String towDigits(int n) => n.toString().padLeft(2, '0');
            final towDigitsMinutes =
                towDigits(duration.inMinutes.remainder(60));
            final towDigitSecond = towDigits(duration.inSeconds.remainder(60));

            //  print('$towDigitsMinutes:$towDigitSecond');
            return Visibility(
              visible: provider.audioFile == null || provider.isRecording,
              replacement: SizedBox(
                width: w / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: SizedBox(
                            child: Text('$towDigitsMinutes:$towDigitSecond'))),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            if (provider.isPlaying) {
                              await provider.audioPlayer.pause();
                            } else {
                              await provider.audioPlayer.play(
                                  DeviceFileSource(provider.audioFile!.path));
                            }
                          },
                          icon: Icon(
                            provider.isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            provider.deleteRecorde();
                          },
                          icon: const Icon(Icons.delete),
                        ),
                        Consumer<ChatProvider>(
                          builder: (context, providerNew, _) {
                            return IconButton(
                              onPressed: () async {
                                await providerNew.sendMessage(
                                  sendParam: SendMessageParam(
                                    message: null,
                                    attachmentFile: provider.audioFile,
                                    messageType: MessageType.audio,
                                    chatId: Get.find<ChatController>().chatId,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.send),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              child: Visibility(
                visible: !provider.isRecording,
                replacement: GestureDetector(
                    onTap: () async {
                      await provider.startRecording();
                    },
                    child: IconButton(
                      onPressed: () async {
                        await provider.stopRecording();
                      },
                      icon: const Icon(Icons.stop_rounded),
                    )),
                child: GestureDetector(
                  onTap: () async {
                    await provider.startRecording();
                  },
                  child: DecoratedIcon(
                    padding: 2.98 * (w / 100),
                    width: 12.93 * (w / 100),
                    height: 12.93 * (w / 100),
                    matchTextDirection: true,
                    color: Get.find<AppController>().darkMode
                        ? AppDarkColors.darkContainer2
                        : Colors.white,
                    imagePath: AppIcons.mic,
                    svgColor: AppDarkColors.greenContainer,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
