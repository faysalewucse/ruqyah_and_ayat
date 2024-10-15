import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/masnun_dua_controller.dart';
import 'package:rukiyah_and_ayat/features/ayat/controllers/verses_controller.dart';

import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_card.dart';
import 'package:rukiyah_and_ayat/widgets/cards/masnun_dua_card.dart';
import 'package:rukiyah_and_ayat/widgets/settings/settings.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';
import 'package:side_sheet/side_sheet.dart';

import '../../utils/constants/app_colors.dart';

class MasnunDuasByCategory extends StatefulWidget {
  final Category category;

  const MasnunDuasByCategory({super.key, required this.category});

  @override
  State<MasnunDuasByCategory> createState() => _MasnunDuasByCategoryState();
}

class _MasnunDuasByCategoryState extends State<MasnunDuasByCategory> {
  final keeperController = Get.find<KeeperController>();
  final masnunDuaController = Get.find<MasnunDuaController>();

  void _initCall() async {
    await masnunDuaController.loadNirapottarDuaByCategory(
        categoryId: widget.category.id);
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
        color: Theme.of(context).primaryColor.withOpacity(0.04),
        padding: const EdgeInsets.all(16.0),
        child: masnunDuaController.masnunDuas.isEmpty
            ? const NoData(
                text: "কোনো দুআ খুজে পাওয়া যায়নি",
              )
            : ListView.separated(
                itemCount: masnunDuaController.masnunDuas.length,
                separatorBuilder: (_, i) => const SizedBox(
                  height: 12,
                ),
                itemBuilder: (context, index) => Obx(
                  () => MasnunDuaCard(
                    masnunDua: masnunDuaController.masnunDuas[index],
                  ),
                ),
              ),
      ),
    );
  }
}
