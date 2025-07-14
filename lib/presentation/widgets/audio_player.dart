import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';

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

class _AppAudioPlayerState extends State<AppAudioPlayer>
    with AutomaticKeepAliveClientMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  bool _isPlaying = false;
  bool _isBuffering = false;
  bool _isLoaded = false;

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

  Future<void> _togglePlayPause() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
        setState(() => _isPlaying = false);
      } else {
        setState(() => _isBuffering = true);

        if (!_isLoaded) {
          await _audioPlayer.setSource(UrlSource(widget.audioUrl));
          _isLoaded = true;
        }

        await _audioPlayer.resume();
        setState(() {
          _isPlaying = true;
          _isBuffering = false;
        });
      }
    } catch (e) {
      setState(() => _isBuffering = false);
      AppSnackBar.openErrorSnackBar(message: "Failed to load audio");
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // مهم مع AutomaticKeepAliveClientMixin
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.radius ?? 12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _isBuffering
                ? const SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppLightColors.pinputColor,
              ),
            )
                : IconButton(
              icon: Icon(
                _isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_fill,
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
                max: _totalDuration.inMilliseconds.toDouble().clamp(1, double.infinity),
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
                    : Colors.black,
              ),
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

  @override
  bool get wantKeepAlive => true;
}
