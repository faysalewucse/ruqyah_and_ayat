import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/category_controller.dart';
import 'package:rukiyah_and_ayat/controllers/masnun_dua_controller.dart';
import 'package:rukiyah_and_ayat/widgets/cards/ayat_category_card.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class MasnunDuaCategories extends StatefulWidget {
  const MasnunDuaCategories({super.key});

  @override
  State<MasnunDuaCategories> createState() => _MasnunDuaCategoriesState();
}

class _MasnunDuaCategoriesState extends State<MasnunDuaCategories> {
  final masnunDuaController = Get.find<MasnunDuaController>();

  void _initCall() async {
    await masnunDuaController.loadMasnunDuaCategories();
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
            () => masnunDuaController.masnunDuaCategories.isEmpty
            ? const NoData(text:  "কোনো ক্যাটাগরী খুজে পাওয়া যায়নি",)
            : Container(
          color: Theme.of(context).canvasColor,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemBuilder: (_, index) => AyatCategoryCard(
              category: masnunDuaController.masnunDuaCategories[index],
              forMasnunDua: true,
            ),
            separatorBuilder: (_, i) => const SizedBox(
              height: 12,
            ),
            itemCount: masnunDuaController.masnunDuaCategories.length,
          ),
        ),
      ),
    );
  }
}
