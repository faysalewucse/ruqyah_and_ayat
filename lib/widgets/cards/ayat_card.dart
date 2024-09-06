import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';

class AyatCard extends StatelessWidget {
  final Verse verse;
  final String selectedFont;

  AyatCard({super.key, required this.verse, required this.selectedFont});

  final keeperController = Get.find<KeeperController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      // decoration: rounded20White,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              verse.title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Obx(() => Text(
              verse.verse,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Theme.of(context).textTheme.titleLarge?.color,
                fontSize: Theme.of(context).textTheme.titleLarge?.fontSize,
                fontFamily: keeperController.ayatListFontFamily.value,
              ),
            )),
          ),
        ],
      ),
    );
  }
}