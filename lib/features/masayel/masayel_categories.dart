import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/masayel_controller.dart';
import 'package:rukiyah_and_ayat/controllers/masnun_dua_controller.dart';
import 'package:rukiyah_and_ayat/widgets/cards/category_card.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class MasayelCategories extends StatefulWidget {
  const MasayelCategories({super.key});

  @override
  State<MasayelCategories> createState() => _MasayelCategoriesState();
}

class _MasayelCategoriesState extends State<MasayelCategories> {
  final masayelController = Get.find<MasayelController>();

  void _initCall() async {
    await masayelController.loadMasayelCategories();
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
      appBar: AppBar(title: const Text("ক্যাটাগরী সমুহ")),
      body: SafeArea(
        child: Obx(
          () =>
              masayelController.masayelCategories.isEmpty
                  ? const NoData(text: "কোনো ক্যাটাগরী খুজে পাওয়া যায়নি")
                  : Container(
                    color: Theme.of(context).canvasColor,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.separated(
                      itemBuilder: (_, index) => CategoryCard(category: masayelController.masayelCategories[index], forMasayel: true),
                      separatorBuilder: (_, i) => const SizedBox(height: 12),
                      itemCount: masayelController.masayelCategories.length,
                    ),
                  ),
        ),
      ),
    );
  }
}
