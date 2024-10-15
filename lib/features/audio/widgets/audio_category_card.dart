import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/audio/audio_category.dart';
import 'package:rukiyah_and_ayat/features/audio/widgets/audio_card.dart';
import 'package:rukiyah_and_ayat/features/audio/widgets/audio_title.dart';

class AudioCategoryCard extends StatelessWidget {
  final AudioCategory audioCategory;
  final int index;

  const AudioCategoryCard(
      {super.key, required this.audioCategory, required this.index});

  @override
  Widget build(BuildContext context) {
    return audioCategory.children.length > 1
        ? ExpansionTile(
            title: AudioTitle(title: audioCategory.title, index: index),
            backgroundColor: Theme.of(context).cardColor,
            collapsedBackgroundColor: Theme.of(context).cardColor,
            tilePadding: const EdgeInsets.symmetric(horizontal: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: rounded20,
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: rounded20,
            ),
            childrenPadding: const EdgeInsets.only(left: 12.0),
            children: [
              ...audioCategory.children.map(
                (audio) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: AudioCard(index: audio.index - 1, audio: audio,),
                ),
              )
            ],
          )
        : AudioCard(index: index, audio: audioCategory.children.first,);
  }
}
