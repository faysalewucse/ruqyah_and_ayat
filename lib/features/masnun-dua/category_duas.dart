import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/masnun_dua_controller.dart';
import 'package:rukiyah_and_ayat/features/ayat/controllers/verses_controller.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_card.dart';
import 'package:rukiyah_and_ayat/widgets/cards/masnun_dua_card.dart';
import 'package:rukiyah_and_ayat/widgets/settings/settings.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';
import 'package:side_sheet/side_sheet.dart';

import '../../utils/constants/app_colors.dart';

class CategoryDuas extends StatefulWidget {
  final Category category;

  const CategoryDuas({super.key, required this.category});

  @override
  State<CategoryDuas> createState() => _CategoryDuasState();
}

class _CategoryDuasState extends State<CategoryDuas> {
  final keeperController = Get.find<KeeperController>();
  final masnunDuaController = Get.find<MasnunDuaController>();

  void _initCall() async {
    await masnunDuaController.loadMasnunDuaByCategory(categoryId: widget.category.id);
  }

  @override
  void initState() {
    super.initState();
    _initCall(); // Fetch verses data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category.label)),
      body: Container(
        color: Theme.of(context).canvasColor,
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () =>
              masnunDuaController.masnunDuas.isEmpty
                  ? const NoData(text: "কোনো দুআ খুজে পাওয়া যায়নি")
                  : ListView.separated(
                    separatorBuilder: (_, i) => const SizedBox(height: 12),
                    itemCount: masnunDuaController.masnunDuas.length,
                    itemBuilder: (_, index) {
                      final masnunDua = masnunDuaController.masnunDuas[index];
                      return InkWell(
                        onTap: () {
                          Get.toNamed(
                            masnunDuas,
                            arguments: {
                              "masnunDuas": masnunDuaController.masnunDuas,
                              "title": widget.category.label,
                              "index": index,
                            },
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(masnunDua.title, style: Theme.of(context).textTheme.titleSmall)),
                              const Icon(PhosphorIcons.caret_right),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
        ),
      ),
    );
  }
}
