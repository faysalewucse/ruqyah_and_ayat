import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/masayel_controller.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/widgets/cards/masnun_dua_card.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';
import 'package:rukiyah_and_ayat/widgets/settings/settings.dart';
import 'package:side_sheet/side_sheet.dart';

import '../../utils/constants/app_colors.dart';

class MasayelsByCategory extends StatefulWidget {
  final Category category;

  const MasayelsByCategory({super.key, required this.category});

  @override
  State<MasayelsByCategory> createState() => _MasayelsByCategoryState();
}

class _MasayelsByCategoryState extends State<MasayelsByCategory> {
  final keeperController = Get.find<KeeperController>();
  final masayelController = Get.find<MasayelController>();

  void _initCall() async {
    await masayelController.loadMasayelsByCategory(categoryId: widget.category.id);
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
                SideSheet.right(context: context, width: MediaQuery.of(context).size.width * 0.7, body: const Settings());
              },
              icon: const Icon(PhosphorIcons.sliders_horizontal, color: AppColors.white),
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.04),
        padding: const EdgeInsets.all(16.0),
        child:
            masayelController.masayels.isEmpty
                ? const NoData(text: "কোনো ক্যাটাগরী খুজে পাওয়া যায়নি")
                : ListView.separated(
                  itemCount: masayelController.masayels.length,
                  separatorBuilder: (_, i) => const SizedBox(height: 12),
                  itemBuilder: (context, index) => Obx(() => MasnunDuaCard(masnunDua: masayelController.masayels[index])),
                ),
      ),
    );
  }
}
