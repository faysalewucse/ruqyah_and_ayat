import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/models/models.dart';

class AyatCard extends StatelessWidget {
  final Ayat verse;
  final String selectedFont;

  AyatCard({required this.verse, required this.selectedFont});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              verse.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white ),
            ),
            const SizedBox(height: 5,),
            Text(
              verse.verse,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: GoogleFonts.getFont(
                selectedFont,
                textStyle: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}