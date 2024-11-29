import 'package:bangla_converter/bangla_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';

class AudioTitle extends StatelessWidget {
  final String title;
  final int index;

  const AudioTitle({
    super.key,
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.0),
            color: Get.isDarkMode
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).primaryColor.withOpacity(0.06),
          ),
          child: Center(
            child: Text(
              BanglaConverter.engToBan("${index + 1}"),
              style: GoogleFonts.tiroBangla(),
            ),
          ),
        ),
        8.kW,
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
