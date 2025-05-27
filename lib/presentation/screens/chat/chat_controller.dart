// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:irhebo/app/app_functions.dart';
import 'package:irhebo/app/enums.dart';
import 'package:irhebo/app/resources/images.dart';
import 'package:irhebo/domain/entities/message_entity.dart';
import 'package:irhebo/presentation/screens/chat/animation_button_controller.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class ChatController extends GetxController with GetTickerProviderStateMixin {
  // final animationController = Get.find<AnimationButtonController>();

  final RxList<ChatMessageEntity> _messages = <ChatMessageEntity>[
    ChatMessageEntity(
        id: "3",
        senderId: "22",
        receiverId: "44",
        message: "Hi leen",
        messageType: "image",
        sender: false,
        timestamp: DateTime(2025, 2, 21, 2, 20, 30)),
    ChatMessageEntity(
        id: "3",
        senderId: "22",
        receiverId: "44",
        message: "Hi chriss",
        messageType: "image",
        sender: true,
        timestamp: DateTime(2025, 2, 21, 2, 22, 30)),
    ChatMessageEntity(
        id: "3",
        senderId: "22",
        receiverId: "44",
        message: "how are you honey",
        messageType: "image",
        sender: false,
        timestamp: DateTime(2025, 2, 21, 2, 24, 30)),
    ChatMessageEntity(
        id: "3",
        senderId: "22",
        receiverId: "44",
        message: "fine thank you, how about you honey? I missed you so much!",
        messageType: "image",
        sender: true,
        timestamp: DateTime(2025, 2, 21, 2, 25, 30)),
    ChatMessageEntity(
        id: "3",
        senderId: "22",
        receiverId: "44",
        message: "awwww , but you know everything is going harder",
        messageType: "image",
        sender: true,
        timestamp: DateTime(2025, 2, 21, 2, 26, 30)),
    //////
    ChatMessageEntity(
        id: "3",
        senderId: "22",
        receiverId: "44",
        message: "Hi leen",
        messageType: "image",
        sender: false,
        timestamp: DateTime(2025, 2, 20, 2, 20, 30)),
    ChatMessageEntity(
        id: "3",
        senderId: "22",
        receiverId: "44",
        message: "Hi chriss",
        messageType: "image",
        sender: false,
        timestamp: DateTime(2025, 2, 20, 2, 22, 30)),
    ChatMessageEntity(
        id: "3",
        senderId: "22",
        receiverId: "44",
        message: "how are you honey",
        messageType: "image",
        sender: true,
        timestamp: DateTime(2025, 2, 20, 2, 24, 30)),
    ChatMessageEntity(
        id: "3",
        senderId: "22",
        receiverId: "44",
        message: "fine thank you, how about you honey? I missed you so much!",
        messageType: "image",
        sender: true,
        timestamp: DateTime(2025, 2, 20, 2, 25, 30)),
    ChatMessageEntity(
        id: "3",
        senderId: "22",
        receiverId: "44",
        message:
            "awwww I miss you too, but you know everything is going harder",
        messageType: "image",
        sender: true,
        timestamp: DateTime(2025, 2, 20, 2, 26, 30))
  ].obs;
  RxMap<String, List<ChatMessageEntity>> groupedMessages =
      <String, List<ChatMessageEntity>>{}.obs;
  List<ChatMessageEntity> get messages => _messages.value;

  ////
  late AnimationController timerController;
  late Animation<double> timerAnimation;
  final Rx<Duration> _duration = Duration.zero.obs;
  late Timer timer;
  Duration get duration => _duration.value;
  set duration(value) => _duration.value = value;
  RxBool isRecord = false.obs;
  RxBool showSearch = false.obs;
  RecorderController recorderController = RecorderController();
  AnimationController? galleryAnimationController;
  AnimationController? audioAnimationController;
  AnimationController? documentAnimationController;
  RxList<String?> selectedFilePath = <String?>[].obs;
  RxBool attachAnimated = false.obs;
  AudioPlayer player = AudioPlayer();
  ChatType type = ChatType.Users;
  Rx<TextEditingController> chatMessage = TextEditingController().obs;
  final ScrollController chatScrollController = ScrollController();

  set messages(List<ChatMessageEntity> value) {
    _messages.value = value;
    groupMessages();
  }

  receiveParameters() {
    type = Get.arguments["chat_type"] ?? ChatType.Users;
    // log(type.toString() + "ASasssssssssssssssssssssassa");
  }

  void groupMessages() {
    Map<String, List<ChatMessageEntity>> grouped = {};

    // Sort messages newest to oldest
    _messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    for (var message in _messages) {
      String formattedDate = formatDate(message.timestamp);
      grouped.putIfAbsent(formattedDate, () => []).add(message);
    }

    groupedMessages.value = grouped; // Assign to reactive map
  }

  scrollToEnd() async {
    await Future.delayed(Duration(milliseconds: 500), () {
      chatScrollController.animateTo(
        chatScrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
  }

  @override
  void onInit() {
    receiveParameters();
    timerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    timerAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: timerController, curve: Curves.linear));
    startTimer();
    stopTimer();
    super.onInit();
    groupMessages();
  }

  onStartTyping() {
    closeAttachments();
    chatMessage.refresh();
  }

  toggleAttachAnimation() {
    FocusScope.of(Get.context!).unfocus();
    if (attachAnimated.value) {
      documentAnimationController?.reverse();
      Future.delayed(50.ms, () {
        audioAnimationController?.reverse();
        Future.delayed(100.ms, () {
          galleryAnimationController?.reverse();
        });
      });
    } else {
      galleryAnimationController?.forward();
      Future.delayed(50.ms, () {
        audioAnimationController?.forward();
        Future.delayed(100.ms, () {
          documentAnimationController?.forward();
        });
      });
    }
    attachAnimated.value = !attachAnimated.value;
  }

  dismissFiles() {
    selectedFilePath.value.clear();
    selectedFilePath.refresh();
    attachAnimated.value = false;
  }

  ignoreRecord() {
    endAnimition();
    stopTimer();
  }

  endAnimition() {
    Get.find<AnimationButtonController>().isMicAnimating = true;
    Get.find<AnimationButtonController>()
        .micController
        .forward()
        .then((value) async {
      Get.find<AnimationButtonController>().micController.reset();
      Get.find<AnimationButtonController>().isMicAnimating = false;
    });
    isRecord.value = false;
  }

  pickChatFile(FileType fileTypee) async {
    chatMessage.value.clear();
    toggleAttachAnimation();
    var result = await FilePicker.platform
        .pickFiles(allowMultiple: true, type: fileTypee);
    if (result != null) {
      selectedFilePath.value = result.paths;
      closeAttachments();
    }
    selectedFilePath.value = result?.paths ?? [];
    closeAttachments();
  }

  stopRecordingAndSend() async {
    log("lets send this record");
    final path = await recorderController.stop();
    releaseRecordAudio(AppSounds.record);
    selectedFilePath.add(path); //TODO need reset the path!!
    isRecord.value = false;
    stopTimer();
    selectedFilePath.clear(); //TODO clear after send
  }

  onTapPrefix() {
    if (isRecord.value) {
      ignoreRecord(); // close record
    } else {
      if (selectedFilePath.isNotEmpty) {
        dismissFiles(); //close
      } else {
        toggleAttachAnimation(); //add
      }
    }
  }

  startTimer() {
    timerController.forward();
    timerController.repeat(reverse: true);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final durationInSecond = duration.inSeconds + 1;
      duration = Duration(seconds: durationInSecond);
    });
  }

  stopTimer() {
    timerController.reset();
    timer.cancel();
    duration = Duration.zero;
  }

  showSearchField() {
    showSearch.value = !showSearch.value;
  }

  onTapSend() {
    if (chatMessage.value.value.text != '') {
      log("send a message"); //send normal message
    } else {
      if (selectedFilePath.isEmpty) {
        if (!isRecord.value) {
          onStartRecording(); //start recording
        } else {
          stopRecordingAndSend(); //sending record
        }
      } else {
        log("send attachment"); //send attachment
      }
    }
  }

  onWillPop() {
    Get.find<AnimationButtonController>().disposeAllControllers();
  }

  releaseRecordAudio(String alarmAudioPath) async {
    await player.setAsset(alarmAudioPath);
    player.play();
  }

  onStartRecording() async {
    if (!isRecord.value) {
      releaseRecordAudio(AppSounds.startRecord);
    }
    Future.delayed(Duration(milliseconds: 700), () {
      startTheRecord();
    });
  }

  initAnimation() {
    stopTimer();
    startTimer();
    recorderController.reset();
    Get.find<AnimationButtonController>().isMicAnimating = false;
    Get.find<AnimationButtonController>().micController.reset();
  }

  onTapField() {
    closeAttachments();
    scrollToEnd();
  }

  closeAttachments() {
    if (attachAnimated.value) {
      toggleAttachAnimation();
    }
  }

  Future<void> startTheRecord() async {
    isRecord.value = true;
    FocusScope.of(Get.context!).unfocus();
    closeAttachments();
    try {
      if (await recorderController.checkPermission()) {
        recorderController.androidEncoder = AndroidEncoder.aac;
        recorderController.androidOutputFormat = AndroidOutputFormat.mpeg4;
        recorderController.iosEncoder = IosEncoder.kAudioFormatMPEG4AAC;
        initAnimation();
        if ((Platform.isIOS || Platform.isMacOS)) {
          var dir = await getTemporaryDirectory();
          await recorderController.record(path: dir.path + "/recording.m4a");
        } else {
          await recorderController.record(sampleRate: 16000, bitRate: 256000);
        }
        isRecord.value = recorderController.isRecording;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> cancelTheRecord() async {
    await recorderController.stop();
    endAnimition();
    stopTimer();
  }

  onTapOutside() {
    FocusScope.of(Get.context!).unfocus();
    closeAttachments();
  }
}
