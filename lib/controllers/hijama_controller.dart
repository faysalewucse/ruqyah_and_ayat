import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/hive_boxes.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';

class HijamaController extends GetxController {
  final hijamaArticles = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHijamaArticlesFromLocal();
  }

  Future<void> loadHijamaArticlesFromLocal() async {
    final savedHijamas = hijamasBox.values.toList();
    if (savedHijamas.isNotEmpty) {
      hijamaArticles(savedHijamas);
    } else {
      // Optionally handle the case where there is no cached data
      print("No articles found in local storage.");
    }
  }

  Future<void> loadArticlesById({required String id}) async {
    final filteredHijamaArticles = hijamasBox.values.where((Article article) => article.id == id).toList();
    if (filteredHijamaArticles.isNotEmpty) {
      hijamaArticles(filteredHijamaArticles);
    } else {
      // Optionally handle the case where no matching data is available
      print("No articles found for the specified index.");
    }
  }
}
