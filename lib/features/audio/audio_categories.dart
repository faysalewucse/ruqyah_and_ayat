import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/features/audio/controllers/audio_controller.dart';
import 'package:rukiyah_and_ayat/features/audio/widgets/audio_category_card.dart';
import 'package:rukiyah_and_ayat/widgets/no_data.dart';

class AudioCategories extends StatefulWidget {
  const AudioCategories({super.key});

  @override
  State<AudioCategories> createState() => _AudioCategoriesState();
}

class _AudioCategoriesState extends State<AudioCategories> {
  final audioController = Get.find<AudioController>();
  bool favourites = false;

  _initCall() async {
    await audioController.loadAudiosFromLocal();
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
        title: const Text("অডিও সমুহ"),
      ),
      body: Obx(
            () => audioController.audioCategories.isEmpty
            ? const NoData(
          text: "কোনো অডিও খুজে পাওয়া যায়নি",
        )
            : Container(
          color: Theme.of(context).canvasColor,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemBuilder: (_, index) => AudioCategoryCard(
              audioCategory: audioController.audioCategories[index],
              index: index,
            ),
            separatorBuilder: (_, i) => const SizedBox(
              height: 12,
            ),
            itemCount: audioController.audioCategories.length,
          ),
        ),
      ),
    );
  }
}
