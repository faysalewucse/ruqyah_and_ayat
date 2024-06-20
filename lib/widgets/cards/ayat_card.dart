import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Ayat.dart';

class AyatCard extends StatelessWidget {
  final Ayat verse;
  final String selectedFont;

  const AyatCard({super.key, required this.verse, required this.selectedFont});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: WHITE,
        borderRadius: rounded8,
        border: Border.all(color: BORDER_COLOR_1)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: PRIMARY_COLOR_LIGHT,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Text(
              verse.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              verse.verse,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}