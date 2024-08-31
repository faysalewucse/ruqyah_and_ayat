import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/global_variables.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';

class ArticleController extends GetxController {
  final articles = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadArticlesFromLocal();
  }

  Future<void> loadArticlesFromLocal() async {
    final savedArticles = articlesBox.values.toList();
    if (savedArticles.isNotEmpty) {
      articles(savedArticles);
    } else {
      // Optionally handle the case where there is no cached data
      print("No articles found in local storage.");
    }
  }

  Future<void> loadArticlesById({required String id}) async {
    final filteredArticles = articlesBox.values.where((Article article) => article.id == id).toList();
    if (filteredArticles.isNotEmpty) {
      articles(filteredArticles);
    } else {
      // Optionally handle the case where no matching data is available
      print("No articles found for the specified index.");
    }
  }
}
