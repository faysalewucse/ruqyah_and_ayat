import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/hive_boxes.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/audio/audio.dart';
import 'package:rukiyah_and_ayat/models/audio/audio_category.dart';

class AudioController extends GetxController {
  final audioCategories = <AudioCategory>[].obs;
  final allAudios = <Audio>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAudiosFromLocal();
  }

  Future<void> loadAudiosFromLocal() async {
    final savedAudios = audioBox.values.toList();

    if (savedAudios.isNotEmpty) {
      allAudios.clear();
      audioCategories(savedAudios);
      for (var audioCategory in audioCategories) {
        allAudios.addAll(audioCategory.children);
      }
    } else {
      print("কোনো অডিও খুজে পাওয়া যায় নি");
    }
  }


  Future<void> loadArticlesById({required String id}) async {
    final filteredAudios = audioBox.values.where((AudioCategory article) => article.id == id).toList();
    if (filteredAudios.isNotEmpty) {
      audioCategories(filteredAudios);
    } else {
      print("কোনো অডিও খুজে পাওয়া যায় নি");
    }
  }
}
