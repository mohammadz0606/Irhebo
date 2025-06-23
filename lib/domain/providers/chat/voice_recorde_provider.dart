

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../app/global_imports.dart';

class VoiceRecorderProvider extends ChangeNotifier {
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  File? audioFile;

  final AudioPlayer audioPlayer = AudioPlayer();
  bool isRecorderReady = false;
bool isRecording = false;
final recorder = FlutterSoundRecorder();

void disposeRecorder(){
  recorder.closeRecorder();
  audioPlayer.dispose();
}
Future<void> initRecorder()async{
  final status = await Permission.microphone.request();
  if(status != PermissionStatus.granted){
    throw 'Microphone Permission not granted';
  }
 await recorder.openRecorder();
  isRecorderReady = true;
  recorder.setSubscriptionDuration(Duration(milliseconds: 500));
}

Future<void> startRecording() async {
  if(!isRecorderReady) return;

      isRecording = true;


      recorder.startRecorder(toFile: 'audio');
      notifyListeners();

  }

  Future stopRecording() async {
  if(!isRecorderReady) return;

      isRecording = false;
final path = await recorder.stopRecorder();
final file = File(path!);
audioFile = file;
notifyListeners();
      print('Recorded Audio $file');
    return null;
  }

  Future<void> deleteRecorde() async {
    audioFile=null;
    notifyListeners();
  }
}
