import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/data/ayat_categories.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_category_card.dart';

class AyatCategories extends StatelessWidget {
  const AyatCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ক্যাটাগরী সমুহ"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemBuilder: (_, index) => AyatCategoryCard(category: categories[index],),
          separatorBuilder: (_, i) => const SizedBox(
            height: 12,
          ),
          itemCount: categories.length,
        ),
      ),
    );
  }
}
