import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/pages/ayat/ayat.dart';

class Category {
  final String name;
  final IconData iconData;
  final Widget Function() page;

  Category(this.name, this.iconData, this.page);
}

class CategoryCard extends StatelessWidget {
  final Category category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => category.page(),
          ),
        )
      ,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.iconData, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              category.name,
              style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}