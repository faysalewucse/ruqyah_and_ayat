// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:rukiyah_and_ayat/features/audio/audio_player.dart';
//
// class AudioTrackCard extends StatelessWidget {
//   final AudioPlayer player;
//   final AudioTrack track;
//   final bool isPlaying;
//   final Duration currentPosition;
//   final Duration totalDuration;
//   final VoidCallback onPlay;
//   final VoidCallback onPause;
//   final VoidCallback onStop;
//
//   const AudioTrackCard({
//     super.key,
//     required this.track,
//     required this.isPlaying,
//     required this.currentPosition,
//     required this.totalDuration,
//     required this.onPlay,
//     required this.onPause,
//     required this.onStop,
//     required this.player,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5),
//         child: ListTile(
//           leading: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               GestureDetector(
//                 onTap: isPlaying ? onPause : onPlay,
//                 child: Container(
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   padding: const EdgeInsets.all(5),
//                   child: isPlaying
//                       ? Icon(Icons.pause, color: Colors.indigo[700], size: 24)
//                       : Icon(Icons.play_arrow, color: Colors.indigo[700], size: 24),
//                 ),
//               ),
//             ],
//           ),
//           title: Text(track.title,
//               style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20)),
//           subtitle: isPlaying ? ProgressBar(
//             baseBarColor: Colors.white,
//             progressBarColor: Colors.white,
//             thumbColor: Colors.white,
//             thumbGlowColor: Colors.white,
//             timeLabelTextStyle: const TextStyle(color: Colors.white),
//             progress: currentPosition,
//             buffered: const Duration(milliseconds: 1000),
//             total: totalDuration,
//             onSeek: (duration) {
//               player.seek(duration);
//             },
//           ) : null,
//         ),
//       ),
//     );
//   }
// }