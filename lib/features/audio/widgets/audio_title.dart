import 'package:bangla_converter/bangla_converter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';

class AudioTitle extends StatelessWidget {
  final String title;
  final int index;
  final bool children;

  const AudioTitle({super.key, required this.title, required this.index, this.children = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        children
            ? const Icon(PhosphorIcons.speaker_simple_high_light)
            : Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10.0),
                color: Get.isDarkMode ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColor.withValues(alpha: 0.06),
              ),
              child: Center(child: Text(BanglaConverter.engToBan("${index + 1}"))),
            ),
        8.kW,
        Expanded(child: Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 16))),
      ],
    );
  }
}
