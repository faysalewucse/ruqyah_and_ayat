import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import 'package:rukiyah_and_ayat/components/cards/audio_player_card.dart';

class AudioTrack {
  final int id;
  final String title;
  final String audioUrl;

  AudioTrack({required this.id, required this.title, required this.audioUrl});
}

class AudioPage extends StatefulWidget {
  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  List<AudioTrack> audioTracks = [
    AudioTrack(
        id: 1,
        title: 'আয়াতুল কুরসি',
        audioUrl:
            'https://cdn.islamic.network/quran/audio/128/ar.alafasy/262.mp3'),
    AudioTrack(
        id: 2,
        title: 'Audio 2',
        audioUrl:
            'https://cdn.islamic.network/quran/audio/128/ar.alafasy/263.mp3'),
  ];

  late AudioPlayer audioPlayer;
  AudioTrack? currentTrack;
  PlayerState audioState = PlayerState.stopped;
  late Duration totalDuration = const Duration(microseconds: 0);
  late Duration currentPosition = const Duration(microseconds: 0);

  Future<List> readAudioData() async {
    List audioList = [];
    ByteData data = await rootBundle.load('assets/audio.xlsx');

    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        audioList.add(AudioTrack(
            id: row[0]!.value,
            title: row[1]!.value.toString(),
            audioUrl: row[2]!.value.toString()));
      }
    }
    return audioList;
  }

  @override
  void initState() {
    super.initState();
    audioPlayer = AudioPlayer();
    audioPlayer.onPlayerStateChanged.listen((event) {
      if (mounted) {
        setState(() {
          audioState = event;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          totalDuration = duration;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((duration) {
      if (mounted) {
        setState(() {
          currentPosition = duration;
        });
      }
    });
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  void playAudio(String url, int id) async {
    if (PlayerState.playing == true) {
      stopAudio();
    }
    await audioPlayer.play(UrlSource(url));
    setState(() {
      currentTrack = audioTracks.firstWhere((track) => track.id == id);
    });
  }

  void pauseAudio() async {
    await audioPlayer.pause();
    setState(() {
      audioState = PlayerState.paused;
    });
  }

  void stopAudio() {
    audioPlayer.stop();
    setState(() {
      audioState = PlayerState.stopped;
      currentPosition = Duration.zero;
    });
  }

  List<String> dropdownOptions = [
    'Option 1',
    'Option 2',
    'Option 3',
    // Add more options here
  ];

  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: const Text('অডিও'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20.0),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              value: selectedOption,
              isExpanded: true,
              items: [
                // Placeholder item
                const DropdownMenuItem<String>(
                  value: null,
                  child: Text('ক্যাটাগরী সিলেক্ট করুন'),
                ),
                // Dropdown options
                ...dropdownOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  selectedOption = newValue;
                  // You can do something based on the selected option if needed
                });
              },
            ),
          ),
          Expanded(
            child:
              ListView.builder(
                    itemCount: audioTracks.length,
                    itemBuilder: (context, index) {
                      final audioTrack = audioTracks[index];
                      final isCurrentTrack = currentTrack == audioTrack;
                      final isPlaying =
                          audioState == PlayerState.playing && isCurrentTrack;
                      return AudioTrackCard(
                        player: audioPlayer,
                        track: audioTrack,
                        isPlaying: isPlaying,
                        currentPosition: currentPosition,
                        totalDuration: totalDuration,
                        onPlay: () =>
                            playAudio(audioTrack.audioUrl, audioTrack.id),
                        onPause: pauseAudio,
                        onStop: stopAudio,
                      );
                    },
                  )
          ),
        ],
      ),
    );
  }
}
