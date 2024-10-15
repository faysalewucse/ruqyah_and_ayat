import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/helper/dialog_helper.dart';
import 'package:rukiyah_and_ayat/helper/hive_boxes.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/models/audio/audio_category.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';
import 'package:rukiyah_and_ayat/services/articles_service.dart';
import 'package:rukiyah_and_ayat/services/audio_service.dart';
import 'package:rukiyah_and_ayat/services/category_service.dart';
import 'package:rukiyah_and_ayat/helper/toast.dart';
import 'package:rukiyah_and_ayat/services/hijama_service.dart';
import 'package:rukiyah_and_ayat/services/masnun_dua_service.dart';
import 'package:rukiyah_and_ayat/services/nirapottar_dua_service.dart';
import 'package:rukiyah_and_ayat/services/verses_service.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/animated_progress_loader.dart';

class DataController extends GetxController {
  final networkController = Get.find<NetworkController>();
  final isLoading = false.obs;
  final progress = 0.0.obs;

  final totalSteps = 8; // Total number of data-fetching steps
  var currentStep = 0;

  // Declare the response variables to store fetched data
  List<Category> responseCategories = [];
  List<Verse> responseVerses = [];
  List<Article> responseArticles = [];
  List<Article> responseHijamas = [];
  List<MasnunDua> responseMasnunDuas = [];
  List<Category> responseMasnunDuaCategories = [];
  List<Article> responseNirapottarDuas = [];
  List<AudioCategory> responseAudios = [];

  Future<void> initDataController() async {
    await _initHive();
    await fetchAndSaveData();
  }

  Future<void> _initHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
  }

  Future<void> updateData() async {
    await _clearBoxes();
    await fetchAndSaveData();
  }

  Future<void> _clearBoxes() async {
    await categoryBox.clear();
    await versesBox.clear();
    await ruqyahsBox.clear();
    await hijamasBox.clear();
    await nirapottarDuaBox.clear();
    await masnunDuaBox.clear();
    await masnunDuaCategoriesBox.clear();
    await audioBox.clear();
  }

  Future<void> fetchAndSaveData() async {
    if (!_isDataStoredLocally() && networkController.hasConnection.isFalse) {
      return DialogHelper.showNoInternetDialog();
    }

    try {
      if(!_isDataStoredLocally()){
        isLoading(true);
        _showLoadingDialog();

        await _fetchCategories();
        await _fetchVerses();
        await _fetchArticles();
        await _fetchHijamas();
        await _fetchMasnunDuas();
        await _fetchMasnunDuaCategories();
        await _fetchNirapottarDuas();
        await _fetchAudios();

        _saveDataToHive();
        showSuccessToast(message: 'অ্যাপের ডেটা সফলভাবে ডাউনলোড হয়েছে!');
      }
    } catch (e) {
      showErrorToast(message: 'অ্যাপের ডেটা ডাউনলোড করতে সমস্যা হয়েছে। আবার চেষ্টা করুন');
      print(e);
    } finally {
      isLoading(false);
      if (Get.isDialogOpen ?? false) Get.back();
    }
  }

  bool _isDataStoredLocally() {
    return categoryBox.values.isNotEmpty &&
        versesBox.values.isNotEmpty &&
        ruqyahsBox.values.isNotEmpty &&
        hijamasBox.values.isNotEmpty &&
        nirapottarDuaBox.values.isNotEmpty &&
        masnunDuaBox.values.isNotEmpty &&
        masnunDuaCategoriesBox.values.isNotEmpty &&
        audioBox.values.isNotEmpty;
  }

  Future<void> _showLoadingDialog() async {
    Get.defaultDialog(
      radius: 20,
      contentPadding: const EdgeInsets.all(20.0),
      title: 'ডেটা প্রস্তুত হচ্ছে',
      titleStyle: primary20W500,
      content: Column(
        children: [
          Obx(() => AnimatedLiquidLinearProgressIndicator(progress: progress.value)),
          20.kH,
          const Text(
            'অ্যাপের ডেটা ডাউনলোড করা হচ্ছে, অনুগ্রহ করে অপেক্ষা করুন...',
            textAlign: TextAlign.center,
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _updateProgress() async {
    currentStep++;
    for (double i = progress.value; i <= currentStep / totalSteps; i += 0.01) {
      progress.value = i;
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  Future<void> _fetchCategories() async {
    final categoriesResponse = await CategoryService.getAllCategories();
    responseCategories = List<Category>.from(
      categoriesResponse.data["categories"].map((e) => Category.fromJson(e)),
    );
    await _updateProgress();
  }

  Future<void> _fetchVerses() async {
    final versesResponse = await VersesService.getVerses();
    responseVerses = List<Verse>.from(
      versesResponse.data["verses"].map((e) => Verse.fromJson(e)),
    );
    await _updateProgress();
  }

  Future<void> _fetchArticles() async {
    final articlesResponse = await ArticlesService.getArticles();
    responseArticles = List<Article>.from(
      articlesResponse.data["articles"].map((e) => Article.fromJson(e)),
    );
    await _updateProgress();
  }

  Future<void> _fetchHijamas() async {
    final hijamasResponse = await HijamaService.getHijamaArticles();
    responseHijamas = List<Article>.from(
      hijamasResponse.data["hijamas"].map((e) => Article.fromJson(e)),
    );
    await _updateProgress();
  }

  Future<void> _fetchMasnunDuas() async {
    final masnunDuasResponse = await MasnunDuaService.getMasnunDuas();
    responseMasnunDuas = List<MasnunDua>.from(
      masnunDuasResponse.data["masnunDuas"].map((e) => MasnunDua.fromJson(e)),
    );
    await _updateProgress();
  }

  Future<void> _fetchMasnunDuaCategories() async {
    final masnunDuaCategoriesResponse = await MasnunDuaService.getMasnunDuaCategories();
    responseMasnunDuaCategories = List<Category>.from(
      masnunDuaCategoriesResponse.data["categories"].map((e) => Category.fromJson(e)),
    );
    await _updateProgress();
  }

  Future<void> _fetchNirapottarDuas() async {
    final nirapottarDuasResponse = await NirapottarDuaService.getNirapottarDuas();
    responseNirapottarDuas = List<Article>.from(
      nirapottarDuasResponse.data["nirapottarDuas"].map((e) => Article.fromJson(e)),
    );
    await _updateProgress();
  }

  Future<void> _fetchAudios() async {
    final audiosResponse = await AudioService.getAllAudios();
    responseAudios = List<AudioCategory>.from(
      audiosResponse.data["audios"].map((e) => AudioCategory.fromJson(e)),
    );
    await _updateProgress();
  }

  Future<void> _saveDataToHive() async {
    await categoryBox.addAll(responseCategories);
    await versesBox.addAll(responseVerses);
    await ruqyahsBox.addAll(responseArticles);
    await hijamasBox.addAll(responseHijamas);
    await masnunDuaBox.addAll(responseMasnunDuas);
    await nirapottarDuaBox.addAll(responseNirapottarDuas);
    await masnunDuaCategoriesBox.addAll(responseMasnunDuaCategories);
    await audioBox.addAll(responseAudios);
  }
}
