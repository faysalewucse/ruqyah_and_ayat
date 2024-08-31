import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/global_variables.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';

class VersesController extends GetxController {
  final verses = <Verse>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadVersesFromHive();
  }

  Future<void> _loadVersesFromHive() async {
    final savedVerses = versesBox.values.toList();
    if (savedVerses.isNotEmpty) {
      verses(savedVerses);
    } else {
      // Optionally handle the case where there is no cached data
      print("No categories found in local storage.");
    }
  }

  Future<List<Verse>> loadVersesByCategory({required String categoryId}) async {
    final filteredVerses = versesBox.values.where((verse) => verse.category == categoryId).toList();
    if (filteredVerses.isNotEmpty) {
      verses(filteredVerses);
      return verses;
    } else {
      // Optionally handle the case where no matching data is available
      print("No categories found for the specified index.");
      return [];
    }
  }
}
