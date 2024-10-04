import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/global_variables.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';

class NirapottarDuaController extends GetxController {
  final nirapottarDuas = <Article>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNirapottarDuaArticlesFromLocal();
  }

  Future<void> loadNirapottarDuaArticlesFromLocal() async {
    final savedNirapottarDuas = nirapottarDuaBox.values.toList();
    if (savedNirapottarDuas.isNotEmpty) {
      nirapottarDuas(savedNirapottarDuas);
    } else {
      // Optionally handle the case where there is no cached data
      print("No articles found in local storage.");
    }
  }

  Future<void> loadArticlesById({required String id}) async {
    final filteredNirapottarDuas = nirapottarDuaBox.values.where((Article article) => article.id == id).toList();
    if (filteredNirapottarDuas.isNotEmpty) {
      nirapottarDuas(filteredNirapottarDuas);
    } else {
      // Optionally handle the case where no matching data is available
      print("No articles found for the specified index.");
    }
  }
}
