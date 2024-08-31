import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/global_variables.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';

class CategoryController extends GetxController {
  final categories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCategoriesFromHive();
  }

  Future<void> _loadCategoriesFromHive() async {
    final savedCategories = categoryBox.values.toList();
    if (savedCategories.isNotEmpty) {
      categories(savedCategories);
    } else {
      // Optionally handle the case where there is no cached data
      print("No categories found in local storage.");
    }
  }

  Future<void> loadCategoriesByCategoryIndex({required int categoryIndex}) async {
    final filteredCategories = categoryBox.values.where((category) => category.categoryIndex == categoryIndex).toList();
    if (filteredCategories.isNotEmpty) {
      categories(filteredCategories);
    } else {
      // Optionally handle the case where no matching data is available
      print("No categories found for the specified index.");
    }
  }
}
