import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rukiyah_and_ayat/db/db_helper.dart';
import 'package:rukiyah_and_ayat/features/audio/controllers/audio_controller.dart';
import 'package:rukiyah_and_ayat/features/audio/helper/audio_helper.dart';
import 'package:rukiyah_and_ayat/features/audio/widgets/audio_player_shimmer.dart';
import 'package:rukiyah_and_ayat/models/audio/audio.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_colors.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_images.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/buttons/primary_button.dart';

class RuqyahPlayer extends StatefulWidget {
  final Audio audio;

  const RuqyahPlayer({super.key, required this.audio});

  @override
  State<RuqyahPlayer> createState() => _RuqyahPlayerState();
}

class _RuqyahPlayerState extends State<RuqyahPlayer> {
  final audioController = Get.find<AudioController>();
  late final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isLooping = false;
  bool _loading = false;
  bool alreadyDownloaded = false;
  Duration _totalDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;
  late final Audio? _prevAudio =
      AudioHelper().getPreviousAudio(currentAudio: widget.audio);
  late final Audio? _nextAudio =
      AudioHelper().getNextAudio(currentAudio: widget.audio);
  bool _isFavorite = false;

  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<Duration?>? _durationSubscription;

  @override
  void initState() {
    super.initState();
    _initializeAudioAndPlay();
  }

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _durationSubscription?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _checkFavoriteStatus() async {
    bool favorite = await isFavorite(
        AudioHelper().getCurrentIndex(currentAudio: widget.audio));
    setState(() {
      _isFavorite = favorite;
    });
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await removeFromFavorites(
          AudioHelper().getCurrentIndex(currentAudio: widget.audio));
    } else {
      await addToFavorites(
          AudioHelper().getCurrentIndex(currentAudio: widget.audio));
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  Future<bool> isFavorite(int id) async {
    final dbHelper = DBHelper();
    return await dbHelper.isFavorite(id);
  }

  Future<void> removeFromFavorites(int id) async {
    final dbHelper = DBHelper();
    await dbHelper.deleteId(id);
  }

  Future<void> addToFavorites(int id) async {
    final dbHelper = DBHelper();
    await dbHelper.insertId(id);
  }

  Future<void> _initializeAudioAndPlay() async {
    _checkFavoriteStatus();
    setState(() => _loading = true);

    _setupAudioListeners();

    try {
      final localPath = await audioController.getLocalFilePath(widget.audio.title);

      if (localPath != null) {
        await _playOffline(localPath);
      } else {
        await _playOnline(convertToDirectUrl(widget.audio.audioUrl));
      }

      setState(() {
        alreadyDownloaded = localPath != null;
        _isPlaying = true;
      });
    } catch (e) {
      debugPrint("Error initializing audio: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  void _setupAudioListeners() {
    _positionSubscription = _audioPlayer.positionStream.listen((position) {
      if (mounted) setState(() => _currentPosition = position);
    });

    _durationSubscription = _audioPlayer.durationStream.listen((duration) {
      if (mounted) setState(() => _totalDuration = duration ?? Duration.zero);
    });
  }

  Future<void> _playOffline(String filePath) async {
    await _audioPlayer.setFilePath(filePath);
    _audioPlayer.play();
  }

  Future<void> _playOnline(String url) async {
    await _audioPlayer.setUrl(url);
    _audioPlayer.play();
  }

  String convertToDirectUrl(String shareableUrl) {
    final regex = RegExp(r'file/d/([^/]+)/');
    final match = regex.firstMatch(shareableUrl);
    if (match == null) throw Exception('Invalid Google Drive URL');
    final fileId = match.group(1);
    return 'https://drive.google.com/uc?id=$fileId&export=download';
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return duration.inHours > 0
        ? '$hours:$minutes:$seconds'
        : '$minutes:$seconds';
  }

  Widget _buildProgressBar(BuildContext context) {
    return Column(
      children: [
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
      ],
    );
  }

  Widget _buildPlayControls(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: CircleAvatar(
            radius: 24, // Adjust size
            backgroundColor: _isLooping ? Theme.of(context).primaryColor : Colors.transparent, // Background color
            child: Icon(
              PhosphorIcons.repeat,
              size: 30,
              color: _isLooping ? Colors.white : Theme.of(context).primaryColor, // Icon color
            ),
          ),
          onPressed: () {
            setState(() {
              _isLooping = !_isLooping;
            });
            _audioPlayer.setLoopMode(
              _isLooping ? LoopMode.one : LoopMode.off,
            );
          },
        ),

        IconButton(
          icon: Opacity(
            opacity: _prevAudio != null ? 1 : 0.4,
            child: Icon(PhosphorIcons.skip_back_fill,
                size: 30, color: Theme.of(context).primaryColor),
          ),
          onPressed: () => _navigateToAudio(_prevAudio),
        ),
        IconButton(
          icon: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, shape: BoxShape.circle),
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
            setState(() => _isPlaying = !_isPlaying);
          },
        ),
        IconButton(
          icon: Opacity(
            opacity: _nextAudio != null ? 1 : 0.4,
            child: Icon(PhosphorIcons.skip_forward_fill,
                size: 30, color: Theme.of(context).primaryColor),
          ),
          onPressed: () => _navigateToAudio(_nextAudio),
        ),
        IconButton(
          icon: Icon(_isFavorite ? PhosphorIcons.heart_fill : PhosphorIcons.heart,
              size: 30, color: _isFavorite ? AppColors.white : Theme.of(context).primaryColor),
          onPressed: _toggleFavorite,
        ),
      ],
    );
  }

  void _navigateToAudio(Audio? audio) {
    if (audio != null) {
      _audioPlayer.dispose();
      Get.offAndToNamed(playAudio, arguments: audio);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.audio.title)),
      body: _loading
          ? const AudioPlayerShimmer()
          : Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 32.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Center(
                      child: Image.asset(AppImages.appLogo, scale: 2.5),
                    ),
                  ),
                  12.kH,
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
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
                          _buildProgressBar(context),
                          _buildPlayControls(context),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: !_loading && !alreadyDownloaded
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Stack(
                  children: [
                    PrimaryButton(
                      label: audioController.downloadingAudioLoading.isTrue
                          ? "ডাউনলোড হচ্ছে... (${audioController.downloadingFileSize.toStringAsFixed(2)} MB - ${audioController.downloadingProgress.value.toInt()}%)"
                          : "ডাউনলোড",
                      onTap: () async {
                        if (audioController.downloadingAudioLoading.isFalse) {
                          await audioController.downloadAudio(
                            convertToDirectUrl(widget.audio.audioUrl),
                            widget.audio.title,
                          );
                        }
                      },
                      suffix: audioController.downloadingAudioLoading.isTrue
                          ? null
                          : Icon(
                              PhosphorIcons.download,
                              color: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.color,
                            ),
                    ),
                    Obx(() => audioController.downloadingAudioLoading.isTrue
                        ? Positioned.fill(
                            right: 10,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () => audioController.cancelDownload(),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white),
                                  child: const Icon(
                                    PhosphorIcons.x,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ))
                        : const SizedBox.shrink())
                  ],
                ),
              ),
            )
          : null,
    );
  }
}
