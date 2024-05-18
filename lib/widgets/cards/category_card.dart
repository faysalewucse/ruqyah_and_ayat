import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => category.page(),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: WHITE,
            border: Border.all(color: BORDER_COLOR_1),
            borderRadius: rounded8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.iconData, size: 40, color: PRIMARY_COLOR),
            const SizedBox(height: 10),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.headlineSmall?.color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
