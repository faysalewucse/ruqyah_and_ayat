import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';

class AyatCategoryCard extends StatelessWidget {
  final Category category;
  final bool forMasnunDua;

  const AyatCategoryCard({super.key, required this.category, this.forMasnunDua = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(!forMasnunDua){
          Get.toNamed(ayatList, arguments: category);
        }
        else{
          Get.toNamed(masnunDuas, arguments: category);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            // border: Border(left: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.5), width: 6)),
            borderRadius: rounded20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                category.label,
                // textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const Icon(PhosphorIcons.caret_right)
          ],
        ),
      ),
    );
  }
}
