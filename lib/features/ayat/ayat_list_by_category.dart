import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/features/ayat/controllers/verses_controller.dart';

import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_colors.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_card.dart';
import 'package:rukiyah_and_ayat/widgets/settings/settings.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';
import 'package:side_sheet/side_sheet.dart';

class AyatListByCategory extends StatefulWidget {
  final Category category;

  const AyatListByCategory({super.key, required this.category});

  @override
  State<AyatListByCategory> createState() => _AyatListByCategoryState();
}

class _AyatListByCategoryState extends State<AyatListByCategory> {
  final keeperController = Get.find<KeeperController>();
  final versesController = Get.find<VersesController>();
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
                SideSheet.right(
                  context: context,
                  width: MediaQuery.of(context).size.width * 0.7,
                  body: const Settings(),
                );
              },
              icon: const Icon(
                PhosphorIcons.sliders_horizontal,
                color: AppColors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: verses.isEmpty
            ? const NoData(
                text: "কোনো আয়াত খুজে পাওয়া যায়নি",
              )
            : ListView.separated(
                itemCount: verses.length,
                separatorBuilder: (_, i) => const SizedBox(
                  height: 40,
                  child: Divider(),
                ),
                itemBuilder: (context, index) => Obx(
                  ()=> AyatCard(
                    verse: verses[index],
                    selectedFont: keeperController.arabicFontFamily.value,
                  ),
                ),
              ),
      ),
    );
  }
}
