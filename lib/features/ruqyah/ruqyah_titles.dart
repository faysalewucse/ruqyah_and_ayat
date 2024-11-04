import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/article_controller.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/widgets/article/article_title_card.dart';
import 'package:rukiyah_and_ayat/widgets/custom_search_field.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class RuqyahTitles extends StatefulWidget {
  const RuqyahTitles({super.key});

  @override
  State<RuqyahTitles> createState() => _RuqyahTitlesState();
}

class _RuqyahTitlesState extends State<RuqyahTitles> {
  final articleController = Get.find<RuqyahController>();
  final TextEditingController searchController = TextEditingController();
  var filteredArticles = <Article>[].obs;

  _initCall() async {
    await articleController.loadArticlesFromLocal();
    filteredArticles.value = articleController.ruqyahs;
  }

  @override
  void initState() {
    super.initState();
    _initCall();
  }

  void _filterArticles(String query) {
    final lowerQuery = query.toLowerCase();
    filteredArticles.value = articleController.ruqyahs
        .where((article) => article.title.toLowerCase().contains(lowerQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        title: const Text("আর্টিক্যাল সমুহ"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: CustomSearchField(searchController: searchController, filterMethod: _filterArticles, hintText: "আর্টিক্যাল",),
          ),
          Expanded(
            child: Obx(
                  () => filteredArticles.isEmpty
                  ? const NoData(
                text: "কোনো আর্টিক্যাল খুজে পাওয়া যায়নি",
              )
                  : ListView.separated(
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (_, index) => ArticleTitleCard(
                  article: filteredArticles[index],
                  index: index,
                ),
                separatorBuilder: (_, i) => const SizedBox(
                  height: 12,
                ),
                itemCount: filteredArticles.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
