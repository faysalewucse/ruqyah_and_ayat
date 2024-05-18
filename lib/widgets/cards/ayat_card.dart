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
      decoration: BoxDecoration(
        color: WHITE,
        borderRadius: rounded8,
        border: Border.all(color: BORDER_COLOR_1)
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              verse.title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 5,),
            Text(
              verse.verse,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}