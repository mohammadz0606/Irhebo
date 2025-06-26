import 'package:audioplayers/audioplayers.dart';

import '../../app/global_imports.dart';

class AppAudioPlayer extends StatefulWidget {
  final String audioUrl;
  final double? radius;

  const AppAudioPlayer({
    super.key,
    required this.audioUrl,
    this.radius,
  });

  @override
  State<AppAudioPlayer> createState() => _AppAudioPlayerState();
}

class _AppAudioPlayerState extends State<AppAudioPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _isPlaying = false;
        _currentPosition = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.audioUrl));
    }

    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius ?? 12),
      child: Container(
        //color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                color: Get.find<AppController>().darkMode
                    ? Colors.white
                    : Colors.black,
                size: 36,
              ),
              onPressed: _togglePlayPause,
            ),
            Expanded(
              child: Slider(
                inactiveColor: Get.find<AppController>().darkMode
                    ? Colors.white
                    : Colors.black,
                min: 0,
                max: _totalDuration.inMilliseconds.toDouble(),
                value: _currentPosition.inMilliseconds
                    .clamp(0, _totalDuration.inMilliseconds)
                    .toDouble(),
                onChanged: (value) async {
                  final position = Duration(milliseconds: value.toInt());
                  await _audioPlayer.seek(position);
                },
              ),
            ),
            Text(
              _formatDuration(_currentPosition),
              style: TextStyle(
                  fontSize: 12,
                  color: Get.find<AppController>().darkMode
                      ? Colors.white
                      : Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return '${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}';
  }
}
