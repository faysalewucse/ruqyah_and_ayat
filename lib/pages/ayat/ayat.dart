import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/components/cards/ayat_card.dart';
import 'package:rukiyah_and_ayat/data/ayats.dart';

class AyatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[500],
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: const Text('রুকইয়ার সাধারণ আয়াত'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10,),
          const Text(
            'أَعُوذُ باللَّهِ مِنَ الشَّيْطانِ الرَّجِيـم',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          const Text(
            ' بِسْمِ اللَّهِ الرَّحْمَـنِ الرَّحِيـمِ',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: quranVerses.length,
              itemBuilder: (context, index) {
                return AyatCard(verse: quranVerses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
