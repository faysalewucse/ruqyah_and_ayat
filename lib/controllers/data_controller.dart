import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/helper/global_variables.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/services/articles_service.dart';
import 'package:rukiyah_and_ayat/services/category_service.dart';
import 'package:rukiyah_and_ayat/helper/toast.dart';
import 'package:rukiyah_and_ayat/services/verses_service.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/custom_loader.dart';

class DataController extends GetxController {
  final networkController = Get.find<NetworkController>();

  final isLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await _initHive();  // Initialize Hive
    await fetchAndSaveCategories(); // Ensure data is fetched after Hive is initialized
  }

  Future<void> _initHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
  }

  Future<void> fetchAndSaveCategories() async {
    if (!networkController.hasConnection.value) {
      Get.defaultDialog(
        title: 'No Internet Connection',
        content: const Text(
          'You need an internet connection to download the app data for the first time.',
        ),
        confirm: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('OK'),
        ),
      );
      return;
    }

    try {
      final savedCategories = categoryBox.values.toList();
      final savedVerses = versesBox.values.toList();
      final savedArticles = articlesBox.values.toList();

      if (savedCategories.isEmpty || savedVerses.isEmpty || savedArticles.isEmpty) {
        isLoading(true);

        Get.defaultDialog(
          radius: 20,
          contentPadding: const EdgeInsets.all(20.0),
          title: 'ডেটা প্রস্তুত হচ্ছে',
          titleStyle: primary20W500,
          content: Column(
            children: [
              const CustomLoader(),
              20.kH,
              const Text('অ্যাপের ডেটা ডাউনলোড করা হচ্ছে, অনুগ্রহ করে অপেক্ষা করুন...'),
            ],
          ),
          barrierDismissible: false, // Prevent dismissing the dialog
        );

        final articlesResponse = await ArticlesService.getArticles();
        final categoriesResponse = await CategoryService.getAllCategories();
        final versesResponse = await VersesService.getVerses();

        List<Category> responseCategories = [];
        List<Verse> responseVerses = [];
        List<Article> responseArticles = [];

        for (var category in categoriesResponse.data["categories"]) {
          final cat = Category.fromJson(category);
          responseCategories.add(cat);
        }

        for (var verse in versesResponse.data["verses"]) {
          final ver = Verse.fromJson(verse);
          responseVerses.add(ver);
        }

        for (var article in articlesResponse.data["articles"]) {
          final art = Article.fromJson(article);
          responseArticles.add(art);
        }

        await categoryBox.clear();
        await versesBox.clear();
        await articlesBox.clear();

        await categoryBox.addAll(responseCategories);
        await versesBox.addAll(responseVerses);
        await articlesBox.addAll(responseArticles);

        showSuccessToast(message: 'অ্যাপের ডেটা সফলভাবে ডাউনলোড হয়েছে!');
      }
    } catch (e) {
      showErrorToast(message: 'Failed to download app data. Please try again.');
      print(e);
    } finally {
      isLoading(false); // End loading
      Get.back(); // Close the dialog
    }
  }
}
