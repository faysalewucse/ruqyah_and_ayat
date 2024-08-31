import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/verses_controller.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_card.dart';
import 'package:rukiyah_and_ayat/widgets/bottom_sheet/font_family_choice_bottom_sheet.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class AyatListByCategory extends StatefulWidget {
  final Category category;

  const AyatListByCategory({super.key, required this.category});

  @override
  State<AyatListByCategory> createState() => _AyatListByCategoryState();
}

class _AyatListByCategoryState extends State<AyatListByCategory> {
  final keeperController = Get.find<KeeperController>();
  final versesController = Get.find<VersesController>();
  String selectedFont = 'Amiri'; // Default font
  List<Verse> verses = []; // Initialize with an empty list

  void _initCall() async {
    List<Verse> loadedVerses = await versesController.loadVersesByCategory(
        categoryId: widget.category.id.toString());
    setState(() {
      verses = loadedVerses; // Update the verses once data is loaded
    });
  }

  @override
  void initState() {
    super.initState();
    _initCall(); // Fetch verses data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.label),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  isScrollControlled: true,
                  builder: (context) {
                    return Obx(
                          () => FontFamilyChoiceBottomSheet(
                        onChanged: (newValue) {
                          keeperController.ayatListFontFamily.value = newValue;
                          Get.back();
                        },
                        selectedFont: keeperController.ayatListFontFamily.value!,
                      ),
                    );
                  },
                );
              },
              icon: const Icon(
                PhosphorIcons.sliders_horizontal,
                color: WHITE,
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: WHITE,
        padding: const EdgeInsets.all(16.0),
        child: verses.isEmpty
            ? const NoData(
          text: "কোনো আয়াত খুজে পাওয়া যায়নি",
        )
            : ListView.separated(
          itemCount: verses.length,
          separatorBuilder: (_, i) => const SizedBox(
            height: 16,
            child: Divider(),
          ),
          itemBuilder: (context, index) => AyatCard(
            verse: verses[index],
            selectedFont: selectedFont,
          ),
        ),
      ),
    );
  }
}
