import 'package:flutter/cupertino.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_card.dart';

class AyatListTab extends StatelessWidget {
  final List ayahList;
  final String selectedFont;
  const AyatListTab({super.key, required this.ayahList, required this.selectedFont});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ayahList.length,
      itemBuilder: (context, index) => AyatCard(
        verse: ayahList[index],
        selectedFont: selectedFont,
      ),
    );
  }
}
