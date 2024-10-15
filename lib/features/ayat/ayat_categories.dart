import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/category_controller.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_category_card.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class AyatCategories extends StatefulWidget {
  final int categoryIndex;

  const AyatCategories({super.key, required this.categoryIndex});

  @override
  State<AyatCategories> createState() => _AyatCategoriesState();
}

class _AyatCategoriesState extends State<AyatCategories> {
  final categoryController = Get.find<CategoryController>();

  void _initCall() async {
    await categoryController.loadCategoriesByCategoryIndex(
        categoryIndex: widget.categoryIndex);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ক্যাটাগরী সমুহ"),
      ),
      body: Obx(
        () => categoryController.categories.isEmpty
                ? const NoData(text:  "কোনো ক্যাটাগরী খুজে পাওয়া যায়নি",)
                : Container(
          color: Theme.of(context).canvasColor,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.separated(
                      itemBuilder: (_, index) => AyatCategoryCard(
                        category: categoryController.categories[index],
                      ),
                      separatorBuilder: (_, i) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: categoryController.categories.length,
                    ),
                  ),
      ),
    );
  }
}
