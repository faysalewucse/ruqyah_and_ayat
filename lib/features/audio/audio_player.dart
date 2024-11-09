import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rukiyah_and_ayat/features/audio/controllers/audio_controller.dart';
import 'package:rukiyah_and_ayat/features/audio/helper/audio_helper.dart';
import 'package:rukiyah_and_ayat/features/audio/widgets/audio_player_shimmer.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/audio/audio.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_colors.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_images.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/buttons/primary_button.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class RuqyahPlayer extends StatefulWidget {
  final Audio audio;

  const RuqyahPlayer({super.key, required this.audio});

  @override
  RuqyahPlayerState createState() => RuqyahPlayerState();
}

class RuqyahPlayerState extends State<RuqyahPlayer> {
  final audioController = Get.find<AudioController>();

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
        // _audioPlayerController.seekTo(_currentPosition.inMilliseconds); // Update waveform position
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
    // _audioPlayerController.dispose();
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
            ? const AudioPlayerShimmer()
            : Container(
                color: Theme.of(context).scaffoldBackgroundColor,
                // padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 32.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0))),
                      child: Center(
                        child: Image.asset(
                          AppImages.appLogo,
                          fit: BoxFit.cover,
                          scale: 2.5,
                        ),
                      ),
                    ),
                    32.kH,
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.audio.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w800,
                                  color: Get.isDarkMode
                                      ? Theme.of(context).iconTheme.color
                                      : Theme.of(context).primaryColor,
                                ),
                              ),
                              32.kH,
                              // Progress bar
                              Slider(
                                min: 0,
                                max: _totalDuration.inSeconds.toDouble(),
                                thumbColor: Theme.of(context).primaryColor,
                                activeColor: Theme.of(context).primaryColor,
                                value: _currentPosition.inSeconds.toDouble(),
                                onChanged: (value) async {
                                  final position =
                                      Duration(seconds: value.toInt());
                                  await _audioPlayer.seek(position);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    icon: Icon(
                                      PhosphorIcons.repeat,
                                      size: 30,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Opacity(
                                      opacity: _prevAudio != null ? 1 : 0.4,
                                      child: Icon(
                                        PhosphorIcons.skip_back_fill,
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_prevAudio != null) {
                                        _audioPlayer.dispose();
                                        Get.offAndToNamed(playAudio,
                                            arguments: _prevAudio);
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: roundedFull),
                                      child: Icon(
                                        _isPlaying
                                            ? Icons.pause
                                            : Icons.play_arrow,
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
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_nextAudio != null) {
                                        _audioPlayer.dispose();
                                        Get.offAndToNamed(playAudio,
                                            arguments: _nextAudio);
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      PhosphorIcons.heart,
                                      size: 30,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))
                  ],
                ),
              ),
      ),
      bottomNavigationBar: !_loading
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => PrimaryButton(
                  label: audioController.downloadingAudioLoading.isTrue
                      ? "ডাউনলোড হচ্ছে..."
                      : "ডাউনলোড",
                  onTap: () async {
                    await audioController.downloadAudio(
                      showPermissionDialog: () =>
                          _showPermissionDialog(context),
                      title: widget.audio.title,
                      audioUrl: widget.audio.audioUrl,
                    );
                  },
                  suffix: audioController.downloadingAudioLoading.isTrue
                      ? null
                      : Icon(
                          PhosphorIcons.download,
                          color:
                              Theme.of(context).textTheme.headlineMedium?.color,
                        ),
                ),
              ),
            )
          : const SizedBox(),
    );
  }

  void _showPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Storage Permission Required"),
        content: const Text(
            "This app needs storage permission to download audio files. Please grant the permission in settings."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await openAppSettings(); // Open app settings if permission is permanently denied
            },
            child: const Text("Go to Settings"),
          ),
        ],
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
    // await _audioPlayerController.preparePlayer(
    //   path: audioStreamUrl.toString(),
    // );
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
