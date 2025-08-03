import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/controllers/storage_controller.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/helper/hive_boxes.dart';
import 'package:rukiyah_and_ayat/helper/toast.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Config.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/models/audio/audio_category.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';
import 'package:rukiyah_and_ayat/services/articles_service.dart';
import 'package:rukiyah_and_ayat/services/audio_service.dart';
import 'package:rukiyah_and_ayat/services/category_service.dart';
import 'package:rukiyah_and_ayat/services/hijama_service.dart';
import 'package:rukiyah_and_ayat/services/masnun_dua_service.dart';
import 'package:rukiyah_and_ayat/services/nirapottar_dua_service.dart';
import 'package:rukiyah_and_ayat/services/verses_service.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/custom_loader.dart';

class DataController extends GetxController {
  final currentAppVersion = ''.obs;
  final networkController = Get.find<NetworkController>();
  final downloadingMessage = "অ্যাপের ডেটা ডাউনলোড করা হচ্ছে, অনুগ্রহ করে অপেক্ষা করুন...".obs;

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
    debugPrint('⬇️ calling fetchAndSaveData()');
    await fetchAndSaveData();
    // await updateData();
  }

  Future<void> _initHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
  }

  Future<void> updateData() async {
    debugPrint('updateData called');
    await _clearBoxes();
    await fetchAndSaveData();
  }

  Future<void> _clearBoxes() async {
    debugPrint('Clearing all Hive boxes...');
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
    debugPrint('fetchAndSaveData called');
    if (networkController.hasConnection.isFalse) {
      return;
    }

    try {
      if (!_isDataStoredLocally()) {
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
        showSuccessToast(message: 'অ্যাপের ডেটা সফলভাবে ডাউনলোড হয়েছে। আলহামদুলিল্লাহ');
      }
    } catch (e) {
      showErrorToast(message: 'অ্যাপের ডেটা ডাউনলোড করতে সমস্যা হয়েছে। আবার চেষ্টা করুন');
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
        children: [const CustomLoader(), 20.kH, Obx(() => Text(downloadingMessage.value, textAlign: TextAlign.center))],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> _fetchCategories() async {
    downloadingMessage("ক্যাটাগরি ডাউনলোড হচ্ছে...");
    final categoriesResponse = await CategoryService.getAllCategories();
    responseCategories = List<Category>.from(categoriesResponse.data["categories"].map((e) => Category.fromJson(e)));
  }

  Future<void> _fetchVerses() async {
    downloadingMessage("আয়াতসমূহ ডাউনলোড হচ্ছে...");
    final versesResponse = await VersesService.getVerses();
    responseVerses = List<Verse>.from(versesResponse.data["verses"].map((e) => Verse.fromJson(e)));
  }

  Future<void> _fetchArticles() async {
    downloadingMessage("আর্টিকেল ডাউনলোড হচ্ছে...");
    final articlesResponse = await ArticlesService.getArticles();
    responseArticles = List<Article>.from(articlesResponse.data["articles"].map((e) => Article.fromJson(e)));
  }

  Future<void> _fetchHijamas() async {
    downloadingMessage("হিজামা আর্টিকেল ডাউনলোড হচ্ছে...");
    final hijamasResponse = await HijamaService.getHijamaArticles();
    responseHijamas = List<Article>.from(hijamasResponse.data["hijamas"].map((e) => Article.fromJson(e)));
  }

  Future<void> _fetchMasnunDuas() async {
    downloadingMessage("মাসনুন দু’আ ডাউনলোড হচ্ছে...");
    final masnunDuasResponse = await MasnunDuaService.getMasnunDuas();
    responseMasnunDuas = List<MasnunDua>.from(masnunDuasResponse.data["masnunDuas"].map((e) => MasnunDua.fromJson(e)));
  }

  Future<void> _fetchMasnunDuaCategories() async {
    downloadingMessage("মাসনুন দু’আ ডাউনলোড হচ্ছে...");
    final masnunDuaCategoriesResponse = await MasnunDuaService.getMasnunDuaCategories();
    responseMasnunDuaCategories = List<Category>.from(
      masnunDuaCategoriesResponse.data["categories"].map((e) => Category.fromJson(e)),
    );
  }

  Future<void> _fetchNirapottarDuas() async {
    downloadingMessage("নিরাপত্তার দু’আ ডাউনলোড হচ্ছে...");
    final nirapottarDuasResponse = await NirapottarDuaService.getNirapottarDuas();
    responseNirapottarDuas = List<Article>.from(
      nirapottarDuasResponse.data["nirapottarDuas"].map((e) => Article.fromJson(e)),
    );
  }

  Future<void> _fetchAudios() async {
    downloadingMessage("অডিও ডাউনলোড হচ্ছে...");
    final audiosResponse = await AudioService.getAllAudios();
    responseAudios = List<AudioCategory>.from(audiosResponse.data["audios"].map((e) => AudioCategory.fromJson(e)));
  }

  Future<void> _saveDataToHive() async {
    await _saveCategoriesToHive();
    await _saveVersesToHive();
    await _saveArticlesToHive();
    await _saveHijamasToHive();
    await _saveMasnunDuasToHive();
    await _saveMasnunDuaCategoriesToHive();
    await _saveNirapottarDuasToHive();
    await _saveAudiosToHive();
  }

  //================== Update Section ===================//
  // Updates only categories data
  Future<void> updateCategories() async {
    downloadingMessage("ক্যাটাগরির কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    print("categories");
    await _clearCategoriesBox();
    await _fetchCategories();
    await _saveCategoriesToHive();
  }

  // Updates only verses data
  Future<void> updateVerses() async {
    downloadingMessage("আয়াতের কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    await _clearVersesBox();
    await _fetchVerses();
    await _saveVersesToHive();
  }

  // Updates only articles data
  Future<void> updateArticles() async {
    downloadingMessage("আর্টিকেলগুলোর কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    await _clearArticlesBox();
    await _fetchArticles();
    await _saveArticlesToHive();
  }

  // Updates only hijamas data
  Future<void> updateHijamas() async {
    downloadingMessage("হিজামার কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    await _clearHijamasBox();
    await _fetchHijamas();
    await _saveHijamasToHive();
  }

  // Updates only masnun duas data
  Future<void> updateMasnunDuas() async {
    downloadingMessage("মাসনুন দুয়ার কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    await _clearMasnunDuasBox();
    await _fetchMasnunDuas();
    await _saveMasnunDuasToHive();
  }

  // Updates only masnun dua categories data
  Future<void> updateMasnunDuaCategories() async {
    downloadingMessage("মাসনুন দুয়া ক্যাটাগরির কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    await _clearMasnunDuaCategoriesBox();
    await _fetchMasnunDuaCategories();
    await _saveMasnunDuaCategoriesToHive();
  }

  // Updates only nirapottar duas data
  Future<void> updateNirapottarDuas() async {
    downloadingMessage("নিরাপত্তার দুয়ার কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    await _clearNirapottarDuasBox();
    await _fetchNirapottarDuas();
    await _saveNirapottarDuasToHive();
  }

  // Updates only audios data
  Future<void> updateAudios() async {
    downloadingMessage("অডিওগুলোর কিছু আপডেট ডাটা ডাউনলোড হচ্ছে। অনুগ্রহ করে অপেক্ষা করুন।");
    await _clearAudiosBox();
    await _fetchAudios();
    await _saveAudiosToHive();
  }

  // Clear individual boxes
  Future<void> _clearCategoriesBox() async => await categoryBox.clear();

  Future<void> _clearVersesBox() async => await versesBox.clear();

  Future<void> _clearArticlesBox() async => await ruqyahsBox.clear();

  Future<void> _clearHijamasBox() async => await hijamasBox.clear();

  Future<void> _clearMasnunDuasBox() async => await masnunDuaBox.clear();

  Future<void> _clearMasnunDuaCategoriesBox() async => await masnunDuaCategoriesBox.clear();

  Future<void> _clearNirapottarDuasBox() async => await nirapottarDuaBox.clear();

  Future<void> _clearAudiosBox() async => await audioBox.clear();

  // Save individual data to Hive
  Future<void> _saveCategoriesToHive() async {
    debugPrint('Saving categories to Hive...');
    await categoryBox.putAll({for (var category in responseCategories) category.id: category});
  }

  Future<void> _saveVersesToHive() async {
    debugPrint('Saving verses to Hive...');
    int i = 0;
    await versesBox.putAll({for (var verse in responseVerses) i++: verse});
  }

  Future<void> _saveArticlesToHive() async {
    debugPrint('Saving articles to Hive...');
    await ruqyahsBox.putAll({for (var article in responseArticles) article.id: article});
  }

  Future<void> _saveHijamasToHive() async {
    debugPrint('Saving hijamas to Hive...');
    await hijamasBox.putAll({for (var hijama in responseHijamas) hijama.id: hijama});
  }

  Future<void> _saveMasnunDuasToHive() async {
    debugPrint('Saving masnun duas to Hive...');
    await masnunDuaBox.putAll({for (var dua in responseMasnunDuas) dua.id: dua});
  }

  Future<void> _saveMasnunDuaCategoriesToHive() async {
    debugPrint('Saving masnun dua categories to Hive...');
    await masnunDuaCategoriesBox.putAll({for (var category in responseMasnunDuaCategories) category.id: category});
  }

  Future<void> _saveNirapottarDuasToHive() async {
    debugPrint('Saving nirapottar duas to Hive...');
    await nirapottarDuaBox.putAll({for (var dua in responseNirapottarDuas) dua.id: dua});
  }

  Future<void> _saveAudiosToHive() async {
    debugPrint('Saving audios to Hive...');
    await audioBox.putAll({for (var audio in responseAudios) audio.id: audio});
  }

  // Version-based update logic
  Future<void> checkAndUpdateData(Config config) async {
    final storageController = Get.find<StorageController>();
    debugPrint('Checking and updating data versions...');

    final currentVersions = {
      'dataVersion': config.dataVersion,
      'ayatDataVersion': config.ayatDataVersion,
      'categoryDataVersion': config.categoryDataVersion,
      'ruqyahDataVersion': config.ruqyahDataVersion,
      'hijamaDataVersion': config.hijamaDataVersion,
      'nirapottarDataVersion': config.nirapottarDataVersion,
      'masnunDuaDataVersion': config.masnunDuaDataVersion,
      'masnunDuaCategoryDataVersion': config.masnunDuaCategoryDataVersion,
      'audioDataVersion': config.audioDataVersion,
      'masayelDataVersion': config.masayelDataVersion,
      'bibidhDataVersion': config.bibidhDataVersion,
      'masayelCategoriesDataVersion': config.masayelCategoriesDataVersion,
    };

    final previousVersions = storageController.getAllDataVersions(currentVersions.keys.toList());

    debugPrint('Previous versions: $previousVersions');
    debugPrint('Current API versions: $currentVersions');

    void saveNewVersions() {
      storageController.saveDataVersions(currentVersions);
      debugPrint('Saving new versions: $currentVersions');
    }

    // If dataVersion changed, update everything
    if (currentVersions['dataVersion'] != previousVersions['dataVersion']) {
      debugPrint('dataVersion changed. Updating all data...');
      downloadingMessage('সব ডাটা আপডেট হচ্ছে, অনুগ্রহ করে অপেক্ষা করুন...');
      await updateData();
      saveNewVersions();
      return;
    }

    // Define updates map
    final updateMap = <String, Future<void> Function()>{
      'ayatDataVersion': () async {
        debugPrint('ayatDataVersion changed. Updating verses...');
        await updateVerses();
      },
      'categoryDataVersion': () async {
        debugPrint('categoryDataVersion changed. Updating categories...');
        await updateCategories();
      },
      'ruqyahDataVersion': () async {
        debugPrint('ruqyahDataVersion changed. Updating articles...');
        await updateArticles();
      },
      'hijamaDataVersion': () async {
        debugPrint('hijamaDataVersion changed. Updating hijamas...');
        await updateHijamas();
      },
      'nirapottarDataVersion': () async {
        debugPrint('nirapottarDataVersion changed. Updating nirapottar duas...');
        await updateNirapottarDuas();
      },
      'masnunDuaDataVersion': () async {
        debugPrint('masnunDuaDataVersion changed. Updating masnun duas...');
        await updateMasnunDuas();
      },
      'masnunDuaCategoryDataVersion': () async {
        debugPrint('masnunDuaCategoryDataVersion changed. Updating masnun dua categories...');
        await updateMasnunDuaCategories();
      },
      'audioDataVersion': () async {
        debugPrint('audioDataVersion changed. Updating audios...');
        await updateAudios();
      },
      // Add more update actions as needed
    };

    // Filter only the updates that need to run
    final updatesToRun =
        updateMap.entries.where((entry) {
          final key = entry.key;
          return currentVersions[key] != previousVersions[key];
        }).toList();

    if (updatesToRun.isNotEmpty) {
      _showLoadingDialog(); // Show only if there's something to update

      for (final update in updatesToRun) {
        await update.value();
      }

      saveNewVersions();
      Get.back(); // Close loading dialog
    }
  }
}
