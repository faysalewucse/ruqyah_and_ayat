import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/storage_controller.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/settings/fonts_drodown.dart';

class FontSettings extends StatelessWidget {
  FontSettings({super.key});

  final keeperController = Get.find<KeeperController>();

  @override
  Widget build(BuildContext context) {
    final selectedFont = keeperController.arabicFontFamily.value;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(border: Border.all(color: PRIMARY_COLOR_LIGHT)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                PhosphorIcons.text_t,
                size: 18,
              ),
              8.kW,
              Text(
                "ফন্ট সেটিংস",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
          16.kH,
          Text(
            "আরবি ফন্ট এর সাইজ",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          12.kH,
          Obx(
            () => Row(
              children: [
                Expanded(
                  child: Slider(
                    activeColor: PRIMARY_COLOR,
                    min: 5,
                    max: 50,
                    value: keeperController.arabicFontSize.value,
                    onChanged: (value) {
                      keeperController.arabicFontSize.value =
                          value.ceil() * 1.0;
                      StorageController().saveDefaultFontSize(value.ceil() * 1.0);
                    },
                  ),
                ),
                Text(
                  "${keeperController.arabicFontSize.value.toInt()}",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          12.kH,
          Text(
            "আরবি ফন্ট ফ্যামিলি",
            style: Theme.of(context).textTheme.bodySmall,
          ),
          12.kH,
          FontSelectorDropdown(
              selectedFont: selectedFont, onChanged: onChanged),
          12.kH,
          Obx(
            () => Text(
              "بِسْمِ ٱللَّٰهِ",
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: keeperController.arabicFontSize.value,
                fontFamily: keeperController.arabicFontFamily.value,
                letterSpacing: 0,
              ),
            ),
          )
        ],
      ),
    );
  }

  void onChanged(String? newValue) {
    keeperController.arabicFontFamily.value = newValue ?? "";
  }
}
