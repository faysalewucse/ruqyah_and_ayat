import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/hive_boxes.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';

class MasayelController extends GetxController {
  final masayels = <MasnunDua>[].obs;
  final masayelCategories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMasayelCategories();
    loadMasayelsFromLocal();
  }

  Future<void> loadMasayelsFromLocal() async {
    final savedMasayels = masayelBox.values.toList();
    debugPrint("Saved masayels length: ${savedMasayels.length}");

    if (savedMasayels.isNotEmpty) {
      masayels(savedMasayels);
    } else {
      // Optionally handle the case where there is no cached data
      debugPrint("No masayels found in local storage.");
    }
  }

  Future<void> loadMasayelsByCategory({required String categoryId}) async {
    debugPrint("Loading masayel by category => $categoryId");
    final savedMasayels = masayelBox.values.where((masayel) => masayel.category == categoryId).toList();
    if (savedMasayels.isNotEmpty) {
      masayels(savedMasayels);
    } else {
      masayels([]);
      debugPrint("No masayels found in local storage.");
    }
  }
  
  Future<void> loadMasayelCategories() async {
    final savedMasayelCategories = masayelCategoriesBox.values.toList();
    if (savedMasayelCategories.isNotEmpty) {
      masayelCategories(savedMasayelCategories);
    } else {
      masayelCategories([]);
    }
  }
  
  Future<void> loadMasayelById({required String id}) async {
    final filteredMasayels = masayelBox.values.where((MasnunDua masayel) => masayel.id == id).toList();
    if (filteredMasayels.isNotEmpty) {
      masayels(filteredMasayels);
    } else {
      // Optionally handle the case where no matching data is available
      debugPrint("No masayels found for the specified index.");
    }
  }
}
