import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/nirapottar_dua_controller.dart';
import 'package:rukiyah_and_ayat/widgets/article/article_title_card.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class NirapottarDuaTitles extends StatefulWidget {
  const NirapottarDuaTitles({super.key});

  @override
  State<NirapottarDuaTitles> createState() => _NirapottarDuaTitlesState();
}

class _NirapottarDuaTitlesState extends State<NirapottarDuaTitles> {
  final nirapottarDuaController = Get.find<NirapottarDuaController>();

  _initCall() async {
    await nirapottarDuaController.loadNirapottarDuaArticlesFromLocal();
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
        title: const Text("হেফাজতের মাসনুন আমল"),
      ),
      body: Obx(
        () => nirapottarDuaController.nirapottarDuas.isEmpty
            ? const NoData(
                text: "কোনো আর্টিক্যাল খুজে পাওয়া যায়নি",
              )
            : Container(
                color: Theme.of(context).canvasColor,
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemBuilder: (_, index) => ArticleTitleCard(
                    article: nirapottarDuaController.nirapottarDuas[index],
                    index: index,
                  ),
                  separatorBuilder: (_, i) => const SizedBox(
                    height: 12,
                  ),
                  itemCount: nirapottarDuaController.nirapottarDuas.length,
                ),
              ),
      ),
    );
  }
}
