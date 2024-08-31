import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/article_controller.dart';
import 'package:rukiyah_and_ayat/widgets/article/article_title_card.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class ArticleTitles extends StatefulWidget {
  const ArticleTitles({super.key});

  @override
  State<ArticleTitles> createState() => _ArticleTitlesState();
}

class _ArticleTitlesState extends State<ArticleTitles> {
  final articleController = Get.find<ArticleController>();

  _initCall() async {
    await articleController.loadArticlesFromLocal();
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
        title: const Text("আর্টিক্যাল সমুহ"),
      ),
      body: Obx(
            () => articleController.articles.isEmpty
            ? const NoData(text:  "কোনো আর্টিক্যাল খুজে পাওয়া যায়নি",)
            : Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemBuilder: (_, index) => ArticleTitleCard(
              article: articleController.articles[index],
            ),
            separatorBuilder: (_, i) => const SizedBox(
              height: 12,
            ),
            itemCount: articleController.articles.length,
          ),
        ),
      ),
    );
  }
}
