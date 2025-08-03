import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_colors.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';

class MasnunDuaCard extends StatelessWidget {
  final MasnunDua masnunDua;

  const MasnunDuaCard({super.key, required this.masnunDua});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          width: deviceWidth,
          decoration: BoxDecoration(
            color: Get.isDarkMode ? Theme.of(context).iconTheme.color : Theme.of(context).primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            masnunDua.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: SelectionArea(
              child: HtmlWidget(
                masnunDua.content,
                textStyle: Get.isDarkMode ? htmlTextStyleDark : htmlTextStyle,
                customStylesBuilder: (element) {
                  return articleStyle;
                },
              ),
            ),
          ),
        ),
      ],
    );

  }
}
