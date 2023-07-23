import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/components/cards/ayat_card.dart';
import 'package:rukiyah_and_ayat/data/ayats.dart';

class AyatPage extends StatefulWidget {
  @override
  _AyatPageState createState() => _AyatPageState();
}

class _AyatPageState extends State<AyatPage> {
  String selectedFont = 'IBM Plex Sans Arabic'; // Default font

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: const Text('রুকইয়ার সাধারণ আয়াত'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'أَعُوذُ باللَّهِ مِنَ الشَّيْطانِ الرَّجِيـم',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const Text(
            ' بِسْمِ اللَّهِ الرَّحْمَـنِ الرَّحِيـمِ',
            textDirection: TextDirection.rtl,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: quranVerses.length,
              itemBuilder: (context, index) {
                return AyatCard(
                    verse: quranVerses[index], selectedFont: selectedFont);
              },
            ),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                title: const Text('ফন্ট পরিবর্তন করুন'),
                content: DropdownButton<String>(
                  value: selectedFont,
                  onChanged: (newValue) {
                    setState(() {
                      selectedFont = newValue!;
                    });
                    Navigator.pop(context); // Close the dialog
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'IBM Plex Sans Arabic',
                      child: Text('IBM Plex Sans Arabic'),
                    ),
                    DropdownMenuItem(
                      value: 'Amiri',
                      child: Text('Amiri'),
                    ),
                    DropdownMenuItem(
                      value: 'Lateef',
                      child: Text('Lateef'),
                    ),
                    DropdownMenuItem(
                      value: 'Reem Kufi',
                      child: Text('Reem Kufi'),
                    ),

                    DropdownMenuItem(
                      value: 'Tajawal',
                      child: Text('Tajawal'),
                    ),
                    DropdownMenuItem(
                      value: 'El Messiri',
                      child: Text('El Messiri'),
                    ),
                    DropdownMenuItem(
                      value: 'Cairo',
                      child: Text('Cairo'),
                    ),
                    DropdownMenuItem(
                      value: 'Almarai',
                      child: Text('Almarai'),
                    ),
                    DropdownMenuItem(
                      value: 'Harmattan',
                      child: Text('Harmattan'),
                    ),
                    DropdownMenuItem(
                      value: 'Noto Naskh Arabic',
                      child: Text('Noto Naskh Arabic'),
                    ),
                    DropdownMenuItem(
                      value: 'Lalezar',
                      child: Text('Lalezar'),
                    ),
                    DropdownMenuItem(
                      value: 'Changa',
                      child: Text('Changa'),
                    ),
                    // Add more fonts here from Google Fonts
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(
          Icons.settings,
          color: Colors.black,
        ),
      ),
    );
  }
}
