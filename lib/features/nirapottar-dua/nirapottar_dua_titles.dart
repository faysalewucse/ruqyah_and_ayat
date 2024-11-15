import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/nirapottar_dua_controller.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/widgets/article/article_title_card.dart';
import 'package:rukiyah_and_ayat/widgets/custom_search_field.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class NirapottarDuaTitles extends StatefulWidget {
  const NirapottarDuaTitles({super.key});

  @override
  State<NirapottarDuaTitles> createState() => _NirapottarDuaTitlesState();
}

class _NirapottarDuaTitlesState extends State<NirapottarDuaTitles> {
  final nirapottarDuaController = Get.find<NirapottarDuaController>();
  final TextEditingController searchController = TextEditingController();
  final filteredNirapottarDuas = <Article>[].obs;

  _initCall() async {
    await nirapottarDuaController.loadNirapottarDuaArticlesFromLocal();
    filteredNirapottarDuas.value = nirapottarDuaController.nirapottarDuas;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initCall();
  }

  void _filterNirapottarDuas(String query) {
    final lowerQuery = query.toLowerCase();
    filteredNirapottarDuas.value = nirapottarDuaController.nirapottarDuas
        .where((article) => article.title.toLowerCase().contains(lowerQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: const Text("হেফাজতের আমল"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: CustomSearchField(
                searchController: searchController,
                filterMethod: _filterNirapottarDuas,
                hintText: "আমল"),
          ),
          Expanded(
            child: Obx(
              () => filteredNirapottarDuas.isEmpty
                  ? const NoData(
                      text: "কোনো আর্টিক্যাল খুজে পাওয়া যায়নি",
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      itemBuilder: (_, index) => ArticleTitleCard(
                        article: filteredNirapottarDuas[index],
                        index: index,
                      ),
                      separatorBuilder: (_, i) => const SizedBox(
                        height: 12,
                      ),
                      itemCount: filteredNirapottarDuas.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
