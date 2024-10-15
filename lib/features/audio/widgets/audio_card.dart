import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/audio/audio.dart';
import 'package:rukiyah_and_ayat/features/audio/widgets/audio_title.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';

class AudioCard extends StatelessWidget {
  final Audio audio;
  final int index;

  const AudioCard({super.key, required this.index, required this.audio});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: rounded20, // Ensure rounded corners for the Material
      child: InkWell(
        borderRadius: rounded20,
        onTap: () {
          Get.toNamed(playAudio, arguments: audio);
        },
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: AudioTitle(title: audio.title, index: index),
        ),
      ),
    );
  }
}
