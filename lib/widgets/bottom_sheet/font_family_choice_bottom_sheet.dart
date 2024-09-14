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
    String arabicText =
        'لَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِلَا إِلٰهَ إِلَّا اللَّهُ مُحَمَّدٌ رَسُولُ اللَّهِ';

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
          const BottomSheetHeader(),
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
                    arabicText,
                    style:
                        const TextStyle(fontFamily: "AlMajeed", fontSize: 20),
                  ),
                  onTap: () {
                    onChanged("AlMajeed");
                  },
                  selected: selectedFont == "AlMajeed",
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    arabicText,
                    style:
                    const TextStyle(fontFamily: "AlMushaf", fontSize: 22),
                  ),
                  onTap: () {
                    onChanged("AlMushaf");
                  },
                  selected: selectedFont == "AlMushaf",
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    arabicText,
                    style:
                    const TextStyle(fontFamily: "MeQuran", fontSize: 22),
                  ),
                  onTap: () {
                    onChanged("MeQuran");
                  },
                  selected: selectedFont == "MeQuran",
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    arabicText,
                    style: GoogleFonts.ibmPlexSansArabic(),
                  ),
                  onTap: () {
                    onChanged(GoogleFonts.ibmPlexSansArabic().fontFamily);
                  },
                  selected: selectedFont ==
                      GoogleFonts.ibmPlexSansArabic().fontFamily,
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    arabicText,
                    style: const TextStyle(
                        fontFamily: "AlQalamKolkata", fontSize: 20),
                  ),
                  onTap: () {
                    onChanged("AlQalamKolkata");
                  },
                  selected: selectedFont == "AlQalamKolkata",
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    arabicText,
                    style: const TextStyle(
                        fontFamily: "AlQalamMajid", fontSize: 20),
                  ),
                  onTap: () {
                    onChanged("AlQalamMajid");
                  },
                  selected: selectedFont == "AlQalamMajid",
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    arabicText,
                    style:
                        const TextStyle(fontFamily: "NooreHira", fontSize: 20),
                  ),
                  onTap: () {
                    onChanged("NooreHira");
                  },
                  selected: selectedFont == "NooreHira",
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    arabicText,
                    style:
                        const TextStyle(fontFamily: "NooreHuda", fontSize: 20),
                  ),
                  onTap: () {
                    onChanged("NooreHuda");
                  },
                  selected: selectedFont == "NooreHuda",
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    arabicText,
                    style: const TextStyle(
                        fontFamily: "QuranRegular", fontSize: 20),
                  ),
                  onTap: () {
                    onChanged("QuranRegular");
                  },
                  selected: selectedFont == "QuranRegular",
                ),
                const Divider(),
                ListTile(
                  title: Text(
                    arabicText,
                    style:
                        const TextStyle(fontFamily: "UthmanTaha", fontSize: 20),
                  ),
                  onTap: () {
                    onChanged("UthmanTaha");
                  },
                  selected: selectedFont == "UthmanTaha",
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
