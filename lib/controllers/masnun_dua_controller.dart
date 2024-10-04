import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/global_variables.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';

class MasnunDuaController extends GetxController {
  final masnunDuas = <MasnunDua>[].obs;
  final masnunDuaCategories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMasnunDuaCategories();
    loadMasnunDuasFromLocal();
  }

  Future<void> loadMasnunDuasFromLocal() async {
    final savedMasnunDuas = masnunDuaBox.values.toList();
    if (savedMasnunDuas.isNotEmpty) {
      masnunDuas(savedMasnunDuas);
    } else {
      // Optionally handle the case where there is no cached data
      print("No articles found in local storage.");
    }
  }

  Future<void> loadNirapottarDuaByCategory({required String categoryId}) async {
    final savedMasnunDuas = masnunDuaBox.values.where((dua) => dua.category == categoryId).toList();
    if (savedMasnunDuas.isNotEmpty) {
      masnunDuas(savedMasnunDuas);
    } else {
      masnunDuas([]);
      print("No articles found in local storage.");
    }
  }
  
  Future<void> loadMasnunDuaCategories() async {
    final savedMasnunDuaCategories = masnunDuaCategoriesBox.values.toList();
    if (savedMasnunDuaCategories.isNotEmpty) {
      masnunDuaCategories(savedMasnunDuaCategories);
    } else {
      masnunDuaCategories([]);
    }
  }
  
  Future<void> loadDuaById({required String id}) async {
    final filteredMasnunDuas = masnunDuaBox.values.where((MasnunDua dua) => dua.id == id).toList();
    if (filteredMasnunDuas.isNotEmpty) {
      masnunDuas(filteredMasnunDuas);
    } else {
      // Optionally handle the case where no matching data is available
      print("No articles found for the specified index.");
    }
  }
}
