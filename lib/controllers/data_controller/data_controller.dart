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
  final progress = 0.0.obs;
  final downloadingMessage =
      "অ্যাপের ডেটা ডাউনলোড করা হচ্ছে, অনুগ্রহ করে অপেক্ষা করুন...".obs;

  final totalSteps = 8.obs;
  var currentStep = 0.obs;

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
    // await updateData();
  }

  Future<void> _initHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
  }

  Future<void> updateData() async {
    await _clearBoxes();
    await fetchAndSaveData();
  }

  Future<void> updateSomeData(List<String> updates) async {
    try {
      progress(0);
      totalSteps(updates.length);
      currentStep(0);
      _showLoadingDialog();

      for (String update in updates) {
        switch (update) {
          case "verses":
            await updateVerses();
            break;
          case "categories":
            await updateCategories();
            break;
          case "articles":
            await updateArticles();
            break;
          case "hijamas":
            await updateHijamas();
            break;
          case "nirapottarDuas":
            await updateNirapottarDuas();
            break;
          case "masnunDuas":
            await updateMasnunDuas();
            break;
          case "masnunDuaCategories":
            await updateMasnunDuaCategories();
            break;
          case "audios":
            await updateAudios();
            break;
          // Uncomment if you want to handle masayel and bibidh in the future
          // case "masayel":
          //   print("Updating masayel...");
          //   await updateMasayel();
          //   break;
          // case "bibidh":
          //   print("Updating bibidh...");
          //   await updateBibidh();
          //   break;
          default:
            print("Unknown update: $update");
        }

        _updateProgress();
      }
    } catch (e) {
      showErrorToast(
          message: 'অ্যাপের ডেটা ডাউনলোড করতে সমস্যা হয়েছে। আবার চেষ্টা করুন');
      print(e);
    } finally {
      if (Get.isDialogOpen ?? false) Get.back();
    }
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
      if (!_isDataStoredLocally()) {
        _showLoadingDialog();

        await _fetchCategories();
        await _updateProgress();
        await _fetchVerses();
        await _updateProgress();
        await _fetchArticles();
        await _updateProgress();
        await _fetchHijamas();
        await _updateProgress();
        await _fetchMasnunDuas();
        await _updateProgress();
        await _fetchMasnunDuaCategories();
        await _updateProgress();
        await _fetchNirapottarDuas();
        await _updateProgress();
        await _fetchAudios();
        await _updateProgress();

        _saveDataToHive();
        showSuccessToast(
            message: 'অ্যাপের ডেটা সফলভাবে ডাউনলোড হয়েছে। আলহামদুলিল্লাহ');
      }
    } catch (e) {
      showErrorToast(
          message: 'অ্যাপের ডেটা ডাউনলোড করতে সমস্যা হয়েছে। আবার চেষ্টা করুন');
      print(e);
    } finally {
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
          Obx(() =>
              AnimatedLiquidLinearProgressIndicator(progress: progress.value)),
          20.kH,
          Obx(() => Text(
                downloadingMessage.value,
                textAlign: TextAlign.center,
              )),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _updateProgress() async {
    currentStep++;
    for (double i = progress.value;
        i <= currentStep / totalSteps.value;
        i += 0.01) {
      progress.value = i;
      await Future.delayed(const Duration(milliseconds: 300));
    }
  }

  Future<void> _fetchCategories() async {
    final categoriesResponse = await CategoryService.getAllCategories();
    responseCategories = List<Category>.from(
      categoriesResponse.data["categories"].map((e) => Category.fromJson(e)),
    );
  }

  Future<void> _fetchVerses() async {
    final versesResponse = await VersesService.getVerses();
    responseVerses = List<Verse>.from(
      versesResponse.data["verses"].map((e) => Verse.fromJson(e)),
    );
  }

  Future<void> _fetchArticles() async {
    final articlesResponse = await ArticlesService.getArticles();
    responseArticles = List<Article>.from(
      articlesResponse.data["articles"].map((e) => Article.fromJson(e)),
    );
  }

  Future<void> _fetchHijamas() async {
    final hijamasResponse = await HijamaService.getHijamaArticles();
    responseHijamas = List<Article>.from(
      hijamasResponse.data["hijamas"].map((e) => Article.fromJson(e)),
    );
  }

  Future<void> _fetchMasnunDuas() async {
    final masnunDuasResponse = await MasnunDuaService.getMasnunDuas();
    responseMasnunDuas = List<MasnunDua>.from(
      masnunDuasResponse.data["masnunDuas"].map((e) => MasnunDua.fromJson(e)),
    );
  }

  Future<void> _fetchMasnunDuaCategories() async {
    final masnunDuaCategoriesResponse =
        await MasnunDuaService.getMasnunDuaCategories();
    responseMasnunDuaCategories = List<Category>.from(
      masnunDuaCategoriesResponse.data["categories"]
          .map((e) => Category.fromJson(e)),
    );
  }

  Future<void> _fetchNirapottarDuas() async {
    final nirapottarDuasResponse =
        await NirapottarDuaService.getNirapottarDuas();
    responseNirapottarDuas = List<Article>.from(
      nirapottarDuasResponse.data["nirapottarDuas"]
          .map((e) => Article.fromJson(e)),
    );
  }

  Future<void> _fetchAudios() async {
    final audiosResponse = await AudioService.getAllAudios();
    responseAudios = List<AudioCategory>.from(
      audiosResponse.data["audios"].map((e) => AudioCategory.fromJson(e)),
    );
  }

  Future<void> _saveDataToHive() async {
    _saveCategoriesToHive();
    _saveVersesToHive();
    _saveArticlesToHive();
    _saveHijamasToHive();
    _saveMasnunDuasToHive();
    _saveMasnunDuaCategoriesToHive();
    _saveNirapottarDuasToHive();
    _saveAudiosToHive();
  }

  //================== Update Section ===================//
  // Updates only categories data
  Future<void> updateCategories() async {
    downloadingMessage("ক্যাটাগরির কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    print("categories");
    await _clearCategoriesBox();
    await _fetchCategories();
    _saveCategoriesToHive();
  }


  // Updates only verses data
  // Updates only verses data
  Future<void> updateVerses() async {
    downloadingMessage("আয়াতের কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    print("verses");
    await _clearVersesBox();
    await _fetchVerses();
    _saveVersesToHive();
  }

// Updates only articles data
  Future<void> updateArticles() async {
    downloadingMessage("আর্টিকেলগুলোর কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    print("articles");
    await _clearArticlesBox();
    await _fetchArticles();
    _saveArticlesToHive();
  }

// Updates only hijamas data
  Future<void> updateHijamas() async {
    downloadingMessage("হিজামার কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    print("hijamas");
    await _clearHijamasBox();
    await _fetchHijamas();
    _saveHijamasToHive();
  }

// Updates only masnun duas data
  Future<void> updateMasnunDuas() async {
    downloadingMessage("মাসনুন দুয়ার কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    print("masnunDuas");
    await _clearMasnunDuasBox();
    await _fetchMasnunDuas();
    _saveMasnunDuasToHive();
  }

// Updates only masnun dua categories data
  Future<void> updateMasnunDuaCategories() async {
    downloadingMessage("মাসনুন দুয়া ক্যাটাগরির কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    print("masnunDuaCategories");
    await _clearMasnunDuaCategoriesBox();
    await _fetchMasnunDuaCategories();
    _saveMasnunDuaCategoriesToHive();
  }

// Updates only nirapottar duas data
  Future<void> updateNirapottarDuas() async {
    downloadingMessage("নিরাপত্তার দুয়ার কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    print("nirapottarDuas");
    await _clearNirapottarDuasBox();
    await _fetchNirapottarDuas();
    _saveNirapottarDuasToHive();
  }

// Updates only audios data
  Future<void> updateAudios() async {
    downloadingMessage("অডিওগুলোর কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    print("audios");
    await _clearAudiosBox();
    await _fetchAudios();
    _saveAudiosToHive();
  }


  // Clear individual boxes
  Future<void> _clearCategoriesBox() async => await categoryBox.clear();

  Future<void> _clearVersesBox() async => await versesBox.clear();

  Future<void> _clearArticlesBox() async => await ruqyahsBox.clear();

  Future<void> _clearHijamasBox() async => await hijamasBox.clear();

  Future<void> _clearMasnunDuasBox() async => await masnunDuaBox.clear();

  Future<void> _clearMasnunDuaCategoriesBox() async =>
      await masnunDuaCategoriesBox.clear();

  Future<void> _clearNirapottarDuasBox() async =>
      await nirapottarDuaBox.clear();

  Future<void> _clearAudiosBox() async => await audioBox.clear();

  // Save individual data to Hive
  Future<void> _saveCategoriesToHive() async =>
      await categoryBox.addAll(responseCategories);

  Future<void> _saveVersesToHive() async =>
      await versesBox.addAll(responseVerses);

  Future<void> _saveArticlesToHive() async =>
      await ruqyahsBox.addAll(responseArticles);

  Future<void> _saveHijamasToHive() async =>
      await hijamasBox.addAll(responseHijamas);

  Future<void> _saveMasnunDuasToHive() async =>
      await masnunDuaBox.addAll(responseMasnunDuas);

  Future<void> _saveMasnunDuaCategoriesToHive() async =>
      await masnunDuaCategoriesBox.addAll(responseMasnunDuaCategories);

  Future<void> _saveNirapottarDuasToHive() async =>
      await nirapottarDuaBox.addAll(responseNirapottarDuas);

  Future<void> _saveAudiosToHive() async =>
      await audioBox.addAll(responseAudios);
}
