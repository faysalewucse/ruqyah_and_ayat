import 'package:flutter/material.dart';

class Ayat {
  final String title;
  final String verseText;

  Ayat({required this.title,  required this.verseText});
}

class AyatCard extends StatelessWidget {
  final Ayat verse;

  AyatCard({required this.verse});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.indigo[800],
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
            Text(
              verse.verseText,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 20, color: Colors.white ),
            ),
          ],
        ),
      ),
    );
  }
}