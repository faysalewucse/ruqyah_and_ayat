import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rukiyah_and_ayat/api/config.dart';
import 'package:rukiyah_and_ayat/db/db_helper.dart';
import 'package:rukiyah_and_ayat/features/audio/helper/audio_helper.dart';
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
  final downloadingProgress = 0.0.obs;
  final downloadingFileSize = 0.0.obs;
  late CancelToken cancelToken;

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

  Future<void> downloadAudio(String url, String filename) async {
    try {
      cancelToken = CancelToken();

      downloadingAudioLoading(true);

      // Get the directory for storing files.
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$filename';

      // Check if the file already exists.
      if (File(filePath).existsSync()) {
        showSuccessToast(message: "ফাইলটি ইতিমধ্যে ডাউনলোড করা হয়েছে।");
        return; // Exit early if file exists.
      }

      // Track progress using Dio's onReceiveProgress.
      await Api().dio.download(url, filePath,
          onReceiveProgress: (receivedBytes, totalBytes) {
        downloadingFileSize(totalBytes / (1024 * 1024));
        if (totalBytes != -1) {
          double progress = (receivedBytes / totalBytes) * 100;
          downloadingProgress(progress);
          if (progress == 100) {
            downloadingProgress(0.0);
            downloadingFileSize(0.0);
          }
        }
      }, cancelToken: cancelToken);

      // Show success message after download completes.
      showSuccessToast(message: "ডাউনলোড সফল হয়েছে।");
    } catch (e) {
      print('Error downloading file: $e');
      throw Exception('Failed to download file');
    } finally {
      downloadingAudioLoading(false);
    }
  }

  void cancelDownload() {
    if (!cancelToken.isCancelled) {
      cancelToken.cancel();
      showSuccessToast(message: "ডাউনলোডটি বাদ দেয়া হয়েছে");
      downloadingProgress(0.0);
      downloadingFileSize(0.0);
    }
  }

  Future<String?> getLocalFilePath(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$filename';
    return File(filePath).existsSync() ? filePath : null;
  }
}
