import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/bottom_sheet/bottom_sheet_header.dart';

class FontFamilyChoiceBottomSheet extends StatelessWidget {
  final Function(String?) onChanged;
  final String selectedFont;
  const FontFamilyChoiceBottomSheet({
    super.key,
    required this.onChanged,
    required this.selectedFont,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: deviceHeight * 0.5,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomSheetHeader(),
          24.kH,
          const Text(
            'ফন্ট পরিবর্তন করুন',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِلَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.ibmPlexSansArabic(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.ibmPlexSansArabic().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.ibmPlexSansArabic().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.amiri(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.amiri().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.amiri().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.lateef(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.lateef().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.lateef().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.reemKufi(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.reemKufi().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.reemKufi().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.tajawal(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.tajawal().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.tajawal().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.elMessiri(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.elMessiri().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.elMessiri().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.cairo(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.cairo().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.cairo().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.almarai(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.almarai().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.almarai().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.harmattan(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.harmattan().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.harmattan().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.notoNaskhArabic(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.notoNaskhArabic().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.notoNaskhArabic().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.lalezar(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.lalezar().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.lalezar().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ',
                    style: GoogleFonts.changa(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.changa().fontFamily);
                  },
                  selected: selectedFont == GoogleFonts.changa().fontFamily,
                ),
                const Divider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
