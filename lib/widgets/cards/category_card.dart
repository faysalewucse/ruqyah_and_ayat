import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/leading_index.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  final bool forMasnunDua;
  final bool forMasayel;

  const CategoryCard({super.key, required this.category, this.forMasnunDua = false, this.forMasayel = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (forMasnunDua) {
          Get.toNamed(categoryDuas, arguments: category);
        } else if (forMasayel) {
          Get.toNamed(masayelsByCategory, arguments: category);
        } else {
          Get.toNamed(ayatList, arguments: category);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: rounded15),
        child: Row(
          children: [
            Expanded(
              child: Row(
                spacing: 8,
                children: [
                  LeadingIndex(index: category.index),
                  Text(
                    category.label,
                    // textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const Icon(PhosphorIcons.caret_right),
          ],
        ),
      ),
    );
  }
}
