import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/article_controller.dart';
import 'package:rukiyah_and_ayat/widgets/article/article_title_card.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class RuqyahTitles extends StatefulWidget {
  const RuqyahTitles({super.key});

  @override
  State<RuqyahTitles> createState() => _RuqyahTitlesState();
}

class _RuqyahTitlesState extends State<RuqyahTitles> {
  final articleController = Get.find<RuqyahController>();

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
        () => articleController.ruqyahs.isEmpty
            ? const NoData(
                text: "কোনো আর্টিক্যাল খুজে পাওয়া যায়নি",
              )
            : Container(
                color: Theme.of(context).canvasColor,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemBuilder: (_, index) => ArticleTitleCard(
                    article: articleController.ruqyahs[index],
                  ),
                  separatorBuilder: (_, i) => const SizedBox(
                    height: 12,
                  ),
                  itemCount: articleController.ruqyahs.length,
                ),
              ),
      ),
    );
  }
}
