import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';

class AyatCategoryCard extends StatelessWidget {
  final Category category;

  const AyatCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(ayatList, arguments: category);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            // border: Border(left: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.5), width: 6)),
            borderRadius: rounded20),
        child: Text(
          category.label,
          // textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
