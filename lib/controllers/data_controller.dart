import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/helper/dialog_helper.dart';
import 'package:rukiyah_and_ayat/helper/global_variables.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';
import 'package:rukiyah_and_ayat/services/articles_service.dart';
import 'package:rukiyah_and_ayat/services/category_service.dart';
import 'package:rukiyah_and_ayat/helper/toast.dart';
import 'package:rukiyah_and_ayat/services/hijama_service.dart';
import 'package:rukiyah_and_ayat/services/masnun_dua_service.dart';
import 'package:rukiyah_and_ayat/services/nirapottar_dua_service.dart';
import 'package:rukiyah_and_ayat/services/verses_service.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/custom_loader.dart';

class DataController extends GetxController {
  final networkController = Get.find<NetworkController>();

  final isLoading = false.obs;

  Future<void> initDataController() async {
    await _initHive(); // Initialize Hive
    await fetchAndSaveData(); // Ensure data is fetched after Hive is initialized
  }

  Future<void> _initHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
  }

  Future<void> updateData() async {
    await categoryBox.clear();
    await versesBox.clear();
    await ruqyahsBox.clear();
    await hijamasBox.clear();
    await nirapottarDuaBox.clear();
    await masnunDuaBox.clear();
    await masnunDuaCategoriesBox.clear();
    await fetchAndSaveData();
  }

  Future<void> fetchAndSaveData() async {
    final savedCategories = categoryBox.values.toList();
    final savedVerses = versesBox.values.toList();
    final savedArticles = ruqyahsBox.values.toList();
    final savedHijamas = hijamasBox.values.toList();
    final savedMasnunDuas = masnunDuaBox.values.toList();
    final savedMasnunDuaCategories = masnunDuaCategoriesBox.values.toList();
    final savedNirapottarDuas = nirapottarDuaBox.values.toList();

    if ((savedCategories.isEmpty ||
            savedVerses.isEmpty ||
            savedArticles.isEmpty ||
            savedMasnunDuas.isEmpty ||
            savedNirapottarDuas.isEmpty ||
            savedMasnunDuaCategories.isEmpty ||
            savedHijamas.isEmpty) &&
        networkController.hasConnection.isFalse) {
      return DialogHelper.showNoInternetDialog();
    }

    try {
      if (savedCategories.isEmpty ||
          savedVerses.isEmpty ||
          savedArticles.isEmpty ||
          savedNirapottarDuas.isEmpty ||
          savedMasnunDuaCategories.isEmpty ||
          savedMasnunDuas.isEmpty ||
          savedHijamas.isEmpty) {
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
              const Text(
                  'অ্যাপের ডেটা ডাউনলোড করা হচ্ছে, অনুগ্রহ করে অপেক্ষা করুন...', textAlign: TextAlign.center,),
            ],
          ),
          barrierDismissible: false, // Prevent dismissing the dialog
        );

        final articlesResponse = await ArticlesService.getArticles();
        final categoriesResponse = await CategoryService.getAllCategories();
        final versesResponse = await VersesService.getVerses();
        final hijamasResponse = await HijamaService.getHijamaArticles();
        final masnunDuasResponse = await MasnunDuaService.getMasnunDuas();
        final masnunDuaCategoriesResponse = await MasnunDuaService.getMasnunDuaCategories();
        final nirapottarDuasResponse = await NirapottarDuaService.getNirapottarDuas();

        List<Category> responseCategories = [];
        List<Verse> responseVerses = [];
        List<Article> responseArticles = [];
        List<Article> responseHijamas = [];
        List<MasnunDua> responseMasnunDuas = [];
        List<Category> responseMasnunDuaCategories = [];
        List<Article> responseNirapottarDuas = [];

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

        for (var hijama in hijamasResponse.data["hijamas"]) {
          final art = Article.fromJson(hijama);
          responseHijamas.add(art);
        }

        for (var dua in nirapottarDuasResponse.data["nirapottarDuas"]) {
          final art = Article.fromJson(dua);
          responseNirapottarDuas.add(art);
        }

        for (var category in masnunDuaCategoriesResponse.data["categories"]) {
          final cat = Category.fromJson(category);
          responseMasnunDuaCategories.add(cat);
        }

        for (var dua in masnunDuasResponse.data["masnunDuas"]) {
          final art = MasnunDua.fromJson(dua);
          responseMasnunDuas.add(art);
        }

        await categoryBox.clear();
        await versesBox.clear();
        await ruqyahsBox.clear();
        await hijamasBox.clear();
        await nirapottarDuaBox.clear();
        await masnunDuaBox.clear();
        await masnunDuaCategoriesBox.clear();

        await categoryBox.addAll(responseCategories);
        await versesBox.addAll(responseVerses);
        await ruqyahsBox.addAll(responseArticles);
        await hijamasBox.addAll(responseHijamas);
        await masnunDuaBox.addAll(responseMasnunDuas);
        await nirapottarDuaBox.addAll(responseNirapottarDuas);
        await masnunDuaCategoriesBox.addAll(responseMasnunDuaCategories);

        showSuccessToast(message: 'অ্যাপের ডেটা সফলভাবে ডাউনলোড হয়েছে!');
      }
    } catch (e) {
      showErrorToast(message: 'Failed to download app data. Please try again.');
      print(e);
    } finally {
      isLoading(false); // End loading
      if (Get.isDialogOpen ?? false) Get.back(); // Close the dialog
    }
  }
}
