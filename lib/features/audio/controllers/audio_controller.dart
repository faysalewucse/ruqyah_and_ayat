import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rukiyah_and_ayat/api/config.dart';
import 'package:rukiyah_and_ayat/helper/hive_boxes.dart';
import 'package:rukiyah_and_ayat/helper/toast.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/audio/audio.dart';
import 'package:rukiyah_and_ayat/models/audio/audio_category.dart';

class AudioController extends GetxController {
  final audioCategories = <AudioCategory>[].obs;
  final downloadingAudioLoading = false.obs;
  final allAudios = <Audio>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAudiosFromLocal();
  }

  Future<void> loadAudiosFromLocal() async {
    final savedAudios = audioBox.values.toList();

    if (savedAudios.isNotEmpty) {
      allAudios.clear();
      audioCategories(savedAudios);
      for (var audioCategory in audioCategories) {
        allAudios.addAll(audioCategory.children);
      }
    } else {
      print("কোনো অডিও খুজে পাওয়া যায় নি");
    }
  }

  Future<void> loadArticlesById({required String id}) async {
    final filteredAudios = audioBox.values
        .where((AudioCategory article) => article.id == id)
        .toList();
    if (filteredAudios.isNotEmpty) {
      audioCategories(filteredAudios);
    } else {
      print("কোনো অডিও খুজে পাওয়া যায় নি");
    }
  }

  Future<void> downloadAudio(
      {required VoidCallback showPermissionDialog,
      required String title,
      required String audioUrl}) async {
    // Check and request storage permission
    if (await Permission.storage.request().isGranted) {
      // Get the Downloads directory
      // Define a path in the public music directory
      Directory? downloadsDir = Directory('/storage/emulated/0/Download/Ruqyah And Ayat');

      // Create the directory if it does not exist
      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      String fileName = "$title.mp3";
      String filePath = "${downloadsDir.path}/$fileName";

      try {
        downloadingAudioLoading(true);
        await Api().dio.download(audioUrl, filePath);
        showSuccessToast(message: "$title ডাউনলোড করা হয়েছে");
      } catch (e) {
        showErrorToast(message: "Downloading failed try again");
      }
      finally{
        downloadingAudioLoading(false);
      }
    } else {
      showPermissionDialog();
    }
  }
}
