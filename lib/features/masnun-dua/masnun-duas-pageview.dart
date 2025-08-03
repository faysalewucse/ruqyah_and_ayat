import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/masnun_dua_controller.dart';
import 'package:rukiyah_and_ayat/features/ayat/controllers/verses_controller.dart';

import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_card.dart';
import 'package:rukiyah_and_ayat/widgets/cards/masnun_dua_card.dart';
import 'package:rukiyah_and_ayat/widgets/settings/settings.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';
import 'package:side_sheet/side_sheet.dart';

import '../../utils/constants/app_colors.dart';

class MasnunDuasByCategory extends StatelessWidget {
  final String title;
  final int index;
  final List<MasnunDua> masnunDuas;

  const MasnunDuasByCategory({super.key, required this.masnunDuas, required this.title, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
              icon: const Icon(PhosphorIcons.sliders_horizontal, color: AppColors.white),
            ),
          ),
        ],
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () =>
              masnunDuas.isEmpty
                  ? const NoData(text: "কোনো দুআ খুজে পাওয়া যায়নি")
                  : PageView.builder(
                    itemCount: masnunDuas.length,
                    controller: PageController(
                      initialPage: index
                    ),
                    itemBuilder: (context, index) {
                      return Obx(() => MasnunDuaCard(masnunDua: masnunDuas[index]));
                    },
                  ),
        ),
      ),
    );
  }
}
