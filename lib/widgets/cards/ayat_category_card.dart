import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/models/Ayat.dart';
import 'package:rukiyah_and_ayat/pages/ayat/ayat_list_by_category.dart';
import 'package:rukiyah_and_ayat/pages/home_page.dart';

class AyatCategoryCard extends StatelessWidget {
  final Category category;

  const AyatCategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AyatListByCategory(category: category),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: WHITE,
          border: Border(left: BorderSide(color: PRIMARY_COLOR.withOpacity(0.5), width: 6)),
          borderRadius: BorderRadius.circular(6.0)
        ),
        child: Text(
          category.label,
          // textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
