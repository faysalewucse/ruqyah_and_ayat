import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

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
            'https://cdn.islamic.network/quran/audio/128/ar.alafasy/262.mp3'),
    // Add more audio tracks here
  ];

  late AudioPlayer audioPlayer;
  AudioTrack? currentTrack;
  PlayerState audioState = PlayerState.stopped;
  Duration? totalDuration;
  Duration? currentPosition;

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

    audioPlayer.onDurationChanged.listen((duration) {
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
    if(PlayerState.playing == true){
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

  void stopAudio() async {
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
              underline: SizedBox(),
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
            child: ListView.builder(
              itemCount: audioTracks.length,
              itemBuilder: (context, index) {
                final audioTrack = audioTracks[index];
                final isCurrentTrack = currentTrack == audioTrack;
                final isPlaying =
                    audioState == PlayerState.playing && isCurrentTrack;
                return AudioTrackCard(
                  track: audioTrack,
                  isPlaying: isPlaying,
                  currentPosition: currentPosition,
                  totalDuration: totalDuration,
                  onPlay: () => playAudio(audioTrack.audioUrl, audioTrack.id),
                  onPause: pauseAudio,
                  onStop: stopAudio,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AudioTrackCard extends StatelessWidget {
  final AudioTrack track;
  final bool isPlaying;
  final Duration? currentPosition;
  final Duration? totalDuration;
  final VoidCallback onPlay;
  final VoidCallback onPause;
  final VoidCallback onStop;

  const AudioTrackCard({
    super.key,
    required this.track,
    required this.isPlaying,
    required this.currentPosition,
    required this.totalDuration,
    required this.onPlay,
    required this.onPause,
    required this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: isPlaying
                  ? Icon(Icons.pause, color: Colors.indigo[700], size: 24)
                  : Icon(Icons.play_arrow, color: Colors.indigo[700], size: 24),
            ),
          ],
        ),
        title: Text(track.title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        subtitle: AudioProgressBar(
          currentPosition: currentPosition,
          totalDuration: totalDuration,
        ),
        trailing: isPlaying
            ? IconButton(
                icon: const Icon(
                  Icons.stop,
                  color: Colors.white,
                ),
                onPressed: onStop)
            : null,
        onTap: isPlaying ? onPause : onPlay,
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  final Duration? currentPosition;
  final Duration? totalDuration;

  const AudioProgressBar(
      {super.key, required this.currentPosition, required this.totalDuration});

  @override
  Widget build(BuildContext context) {
    final positionText = currentPosition != null
        ? currentPosition!.toString().split('.').first
        : '0:00';
    final durationText = totalDuration != null
        ? totalDuration!.toString().split('.').first
        : '0:00';

    return Row(
      children: [
        Text(
          positionText,
          style: const TextStyle(color: Colors.white),
        ),
        Expanded(
          child: Slider(
            activeColor: Colors.white,
            value: currentPosition?.inMilliseconds.toDouble() ?? 0.0,
            onChanged: (value) {},
            max: totalDuration?.inMilliseconds.toDouble() ?? 0.0,
          ),
        ),
        Text(durationText, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
