import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rukiyah_and_ayat/features/audio/helper/audio_helper.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/audio/audio.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_colors.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_images.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/custom_loader.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class RuqyahPlayer extends StatefulWidget {
  final Audio audio;

  const RuqyahPlayer({super.key, required this.audio});

  @override
  RuqyahPlayerState createState() => RuqyahPlayerState();
}

class RuqyahPlayerState extends State<RuqyahPlayer> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  bool _loading = false;
  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  late Audio? _prevAudio;
  late Audio? _nextAudio;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Listen to the player's position and duration changes
    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position;
        });
      }
    });

    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      if (mounted) {
        setState(() {
          _totalDuration = duration ?? Duration.zero;
        });
      }
    });

    _prevAudio = AudioHelper().getPreviousAudio(currentAudio: widget.audio);
    _nextAudio = AudioHelper().getNextAudio(currentAudio: widget.audio);

    _playYouTubeAudio();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();

    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.audio.title),
      ),
      body: Center(
        child: _loading
            ? const CustomLoader()
            : Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0), // Set the border radius
                      child: Image.asset(
                        Get.isDarkMode ? AppImages.appIconDark : AppImages.appIconLight,
                        height: deviceHeight * 0.3,
                        fit: BoxFit.cover, // Optional: Ensures the image fits the container
                      ),
                    ),
                    32.kH,
                    Text(
                      widget.audio.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Get.isDarkMode ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColor,
                      ),
                    ),
                    20.kH,
                    // Progress bar
                    Slider(
                      min: 0,
                      max: _totalDuration.inSeconds.toDouble(),
                      thumbColor: Theme.of(context).primaryColor,
                      activeColor: Theme.of(context).primaryColor,
                      value: _currentPosition.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await _audioPlayer.seek(position);
                      },
                    ),
                    // Display the current position and total duration
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(_currentPosition)),
                          Text(_formatDuration(_totalDuration)),
                        ],
                      ),
                    ),
                    // Play/Pause button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Opacity(
                            opacity: _prevAudio != null ? 1 : 0.4,
                            child: Icon(
                              PhosphorIcons.skip_back_fill,
                              size: 40,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {
                            if(_prevAudio != null){
                              _audioPlayer.dispose();
                              Get.offAndToNamed(playAudio, arguments: _prevAudio);
                            }
                          },
                        ),
                        IconButton(
                          icon: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: roundedFull),
                            child: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: AppColors.white,
                              size: 40,
                            ),
                          ),
                          onPressed: () async {
                            if (_isPlaying) {
                              await _audioPlayer.pause();
                            } else {
                              await _audioPlayer.play();
                            }
                            setState(() {
                              _isPlaying = !_isPlaying;
                            });
                          },
                        ),
                        IconButton(
                          icon: Opacity(
                            opacity: _nextAudio != null ? 1 : 0.4,
                            child: Icon(
                              PhosphorIcons.skip_forward_fill,
                              size: 40,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          onPressed: () {
                            if(_nextAudio != null){
                              _audioPlayer.dispose();
                              Get.offAndToNamed(playAudio, arguments: _nextAudio);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _playYouTubeAudio() async {
    setState(() {
      _loading = true;
    });

    // Initialize YouTube Explode
    var yt = YoutubeExplode();

    // Get video ID from URL
    var video = await yt.videos.get(widget.audio.audioUrl);

    // Get the audio stream
    var manifest = await yt.videos.streamsClient.getManifest(video.id);
    var audioStreamInfo = manifest.audioOnly.withHighestBitrate();
    var audioStreamUrl = audioStreamInfo.url;

    // Play the audio
    await _audioPlayer.setUrl(audioStreamUrl.toString());
    _audioPlayer.play();

    setState(() {
      _isPlaying = true;
      _loading = false;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (duration.inHours > 0) hours, minutes, seconds].join(':');
  }
}
