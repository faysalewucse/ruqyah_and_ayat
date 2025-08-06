import 'package:flutter/cupertino.dart';
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
      debugPrint("কোনো ক্যাটাগরী খুজে পাওয়া যায়নি");
    }
  }

  Future<List<Verse>> loadVersesByCategory({required String categoryId}) async {
    final filteredVerses =
        versesBox.values.where((verse) => verse.category == categoryId).toList()
          ..sort((a, b) {
            if (a.index == null && b.index == null) return 0;
            if (a.index == null) return 1; // a goes after b
            if (b.index == null) return -1; // a goes before b
            return a.index!.compareTo(b.index!);
          });

    if (filteredVerses.isNotEmpty) {
      verses(filteredVerses);
      return verses;
    } else {
      // Optionally handle the case where no matching data is available
      debugPrint("কোনো ক্যাটাগরী খুজে পাওয়া যায়নি");
      return [];
    }
  }
}
