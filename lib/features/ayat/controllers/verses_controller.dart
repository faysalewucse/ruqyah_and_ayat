import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/hive_boxes.dart';
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
      print("কোনো ক্যাটাগরী খুজে পাওয়া যায়নি");
    }
  }

  Future<List<Verse>> loadVersesByCategory({required String categoryId}) async {
    // Filter the verses based on the categoryId
    final filteredVerses = versesBox.values
        .where((verse) => verse.category == categoryId)
        .toList()
      ..sort((a, b) {
        // Handle null values for index by treating them as the lowest priority (e.g., placing them at the start or end)
        final indexA = a.index ?? -1; // Assign a default value for null, e.g., -1
        final indexB = b.index ?? -1;
        return indexA.compareTo(indexB);
      });

    if (filteredVerses.isNotEmpty) {
      verses(filteredVerses);
      return filteredVerses; // Ensure the filtered list is returned
    } else {
      // Optionally handle the case where no matching data is available
      print("কোনো ক্যাটাগরী খুজে পাওয়া যায়নি");
      return [];
    }
  }

}
