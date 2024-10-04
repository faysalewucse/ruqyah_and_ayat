import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';

class FontSelectorDropdown extends StatefulWidget {
  final String selectedFont;
  final ValueChanged<String> onChanged;

  const FontSelectorDropdown({
    super.key,
    required this.selectedFont,
    required this.onChanged,
  });

  @override
  FontSelectorDropdownState createState() => FontSelectorDropdownState();
}

class FontSelectorDropdownState extends State<FontSelectorDropdown> {
  final List<Map<String, dynamic>> fonts = [
    {"name": "আল মাজিদ", "value": "AlMajeed", "fontFamily": "AlMajeed"},
    {"name": "আল মুসহাফ", "value": "AlMushaf", "fontFamily": "AlMushaf"},
    {"name": "মি কুরআন", "value": "MeQuran", "fontFamily": "MeQuran"},
    {"name": "Sans Arabic", "value": GoogleFonts.ibmPlexSansArabic().fontFamily, "fontFamily": "Sans Arabic"},
    {"name": "আল ক্বলাম কলকাতা", "value": "AlQalamKolkata", "fontFamily": "AlQalamKolkata"},
    {"name": "আল ক্বলাম মাজীদ", "value": "AlQalamMajid", "fontFamily": "AlQalamMajid"},
    {"name": "নুরেহিরা", "value": "NooreHira", "fontFamily": "NooreHira"},
    {"name": "নুরেহুদা", "value": "NooreHuda", "fontFamily": "NooreHuda"},
    {"name": "কুরআন রেগুলার", "value": "QuranRegular", "fontFamily": "QuranRegular"},
    {"name": "উসমান ত্বহা", "value": "UthmanTaha", "fontFamily": "UthmanTaha"},
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: widget.selectedFont,
      isExpanded: true,
      icon: const Icon(PhosphorIcons.caret_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: GRAY, width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: PRIMARY_COLOR, width: 2.0),
        ),
      ),
      onChanged: (String? newValue) {
        widget.onChanged(newValue!); // Handle font change
      },
      items: fonts.map<DropdownMenuItem<String>>((Map<String, dynamic> font) {
        return DropdownMenuItem<String>(
          value: font["value"],
          child: Text(
            font["name"],
            style: Theme.of(context).textTheme.displaySmall,
          ),
        );
      }).toList(),
    );
  }
}
