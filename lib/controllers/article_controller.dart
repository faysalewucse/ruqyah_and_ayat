import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/global_variables.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';

class RuqyahController extends GetxController {
  final ruqyahs = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadArticlesFromLocal();
  }

  Future<void> loadArticlesFromLocal() async {
    final savedRuqyahs = ruqyahsBox.values.toList();
    if (savedRuqyahs.isNotEmpty) {
      ruqyahs(savedRuqyahs);
    } else {
      // Optionally handle the case where there is no cached data
      print("No articles found in local storage.");
    }
  }

  Future<void> loadArticlesById({required String id}) async {
    final filteredRuqyahs = ruqyahsBox.values.where((Article article) => article.id == id).toList();
    if (filteredRuqyahs.isNotEmpty) {
      ruqyahs(filteredRuqyahs);
    } else {
      // Optionally handle the case where no matching data is available
      print("No articles found for the specified index.");
    }
  }
}
