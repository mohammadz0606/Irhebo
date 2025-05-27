import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class WaveWidget extends StatelessWidget {
  final RecorderController recorder;
  const WaveWidget({
    super.key,
    required this.recorder,
  });

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return AudioWaveforms(
      size: Size(1 * w * (0.4), (1 * w) * (0.11)),
      recorderController: recorder,
      enableGesture: false,
      waveStyle: WaveStyle(
        spacing: 8.0,
        showBottom: true,
        extendWaveform: true,
        showMiddleLine: false,
        gradient: ui.Gradient.linear(
          const Offset(70, 50),
          Offset(MediaQuery.of(context).size.width / 2, 0),
          [Colors.red, Colors.green],
        ),
      ),
    );
  }
}
