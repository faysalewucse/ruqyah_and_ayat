import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/features/masnun-dua/masnun_dua_categories.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/helper/dialog_helper.dart';
import 'package:rukiyah_and_ayat/helper/hive_boxes.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/models/audio/audio_category.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
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

enum DataType {
  categories,
  verses,
  articles,
  hijamas,
  masnunDuas,
  masnunDuaCategories,
  nirapottarDuas,
  audios,
  masayel,
  masayelCategories,
}

class DataProgress {
  final String title;
  final String message;
  final double progress;
  final DataType? currentDataType;

  DataProgress({
    required this.title,
    required this.message,
    required this.progress,
    this.currentDataType,
  });
}

class DataController extends GetxController {
  final networkController = Get.find<NetworkController>();

  // Progress tracking
  final Rx<DataProgress> dataProgress = DataProgress(
    title: 'প্রস্তুত হচ্ছে',
    message: 'অনুগ্রহ করে অপেক্ষা করুন...',
    progress: 0.0,
  ).obs;

  final RxBool isLoading = false.obs;
  final RxBool isUpdating = false.obs;
  final RxBool isSelectiveUpdate = false.obs;

  // Data storage
  final Map<DataType, dynamic> _responseData = {};

  // Data type configurations
  static const Map<DataType, String> _dataTypeMessages = {
    DataType.categories: 'ক্যাটাগরি ডাউনলোড হচ্ছে...',
    DataType.verses: 'আয়াত ডাউনলোড হচ্ছে...',
    DataType.articles: 'আর্টিকেল ডাউনলোড হচ্ছে...',
    DataType.hijamas: 'হিজামা ডাউনলোড হচ্ছে...',
    DataType.masnunDuas: 'মাসনুন দুয়া ডাউনলোড হচ্ছে...',
    DataType.masnunDuaCategories: 'মাসনুন দুয়া ক্যাটাগরি ডাউনলোড হচ্ছে...',
    DataType.nirapottarDuas: 'নিরাপত্তার দুয়া ডাউনলোড হচ্ছে...',
    DataType.audios: 'অডিও ডাউনলোড হচ্ছে...',
    DataType.masayel: 'মাসায়েল ডাউনলোড হচ্ছে...',
    DataType.masayelCategories: 'মাসায়েল ক্যাটাগরি ডাউনলোড হচ্ছে...',
  };

  Future<void> initDataController() async {
    await _initHive();
    await fetchAndSaveData();
  }

  Future<void> _initHive() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocDir.path);
  }

  Future<void> updateData() async {
    debugPrint("Updating all data");
    await _clearAllBoxes();
    await fetchAndSaveData();
  }

  Future<void> updateSomeData(List<String> updates) async {
    if (updates.isEmpty) return;

    try {
      isUpdating(true);
      isSelectiveUpdate(true); // Flag to prevent fetchAndSaveData from running

      _updateProgress(
        title: 'আপডেট হচ্ছে',
        message: 'আপডেট শুরু হচ্ছে...',
        progress: 0.0,
      );

      _showLoadingDialog();

      final List<DataType> dataTypesToUpdate = _parseUpdateTypes(updates);
      debugPrint("Updating specific data types: $dataTypesToUpdate");

      for (int i = 0; i < dataTypesToUpdate.length; i++) {
        final dataType = dataTypesToUpdate[i];
        final progress = (i / dataTypesToUpdate.length);

        _updateProgress(
          title: 'আপডেট হচ্ছে',
          message: _dataTypeMessages[dataType] ?? 'ডাউনলোড হচ্ছে...',
          progress: progress,
          currentDataType: dataType,
        );

        await _updateSingleDataType(dataType);
        debugPrint("Successfully updated: $dataType");
      }

      _updateProgress(
        title: 'সম্পন্ন',
        message: 'আপডেট সফল হয়েছে',
        progress: 1.0,
      );

      showSuccessToast(message: 'ডেটা সফলভাবে আপডেট হয়েছে');

    } catch (e) {
      showErrorToast(message: 'আপডেট করতে সমস্যা হয়েছে। আবার চেষ্টা করুন');
      debugPrint("Error on updates => $e");
    } finally {
      isUpdating(false);
      isSelectiveUpdate(false); // Reset flag
      if (Get.isDialogOpen ?? false) Get.back();
    }
  }

  List<DataType> _parseUpdateTypes(List<String> updates) {
    return updates.map((update) {
      switch (update) {
        case "verses": return DataType.verses;
        case "categories": return DataType.categories;
        case "articles": return DataType.articles;
        case "hijamas": return DataType.hijamas;
        case "nirapottarDuas": return DataType.nirapottarDuas;
        case "masnunDuas": return DataType.masnunDuas;
        case "masnunDuaCategories": return DataType.masnunDuaCategories;
        case "audios": return DataType.audios;
        case "masayel": return DataType.masayel;
        case "masayelCategories": return DataType.masayelCategories;
        default:
          debugPrint("Unknown update type: $update");
          return null;
      }
    }).where((element) => element != null).cast<DataType>().toList();
  }

  Future<void> _updateSingleDataType(DataType dataType) async {
    try {
      debugPrint("Clearing box for: $dataType");
      await _clearSingleBox(dataType);

      debugPrint("Fetching data for: $dataType");
      await _fetchSingleDataType(dataType);

      debugPrint("Saving data for: $dataType");
      await _saveSingleDataType(dataType);

      debugPrint("Successfully completed update for: $dataType");
    } catch (e) {
      debugPrint("Error updating $dataType: $e");
      rethrow;
    }
  }

  Future<void> fetchAndSaveData() async {
    // Don't run if selective update is in progress
    if (isSelectiveUpdate.value) {
      debugPrint("Selective update in progress - skipping fetchAndSaveData");
      return;
    }

    if (!_isDataStoredLocally() && !networkController.hasConnection.value) {
      return DialogHelper.showNoInternetDialog();
    }

    if (_isDataStoredLocally()) {
      debugPrint("Data already exists locally - skipping initial download");
      return;
    }

    try {
      isLoading(true);
      debugPrint("Starting initial data download - clearing all boxes");
      _showLoadingDialog();
      await _clearAllBoxes();

      final dataTypes = DataType.values;

      for (int i = 0; i < dataTypes.length; i++) {
        final dataType = dataTypes[i];
        final progress = (i / dataTypes.length);

        _updateProgress(
          title: 'ডেটা প্রস্তুত হচ্ছে',
          message: _dataTypeMessages[dataType] ?? 'ডাউনলোড হচ্ছে...',
          progress: progress,
          currentDataType: dataType,
        );

        await _fetchSingleDataType(dataType);
      }

      _updateProgress(
        title: 'সংরক্ষণ হচ্ছে',
        message: 'ডেটা সংরক্ষণ করা হচ্ছে...',
        progress: 0.9,
      );

      await _saveAllDataToHive();

      _updateProgress(
        title: 'সম্পন্ন',
        message: 'সফলভাবে ডাউনলোড হয়েছে',
        progress: 1.0,
      );

      showSuccessToast(message: 'অ্যাপের ডেটা সফলভাবে ডাউনলোড হয়েছে। আলহামদুলিল্লাহ');

    } catch (e) {
      showErrorToast(message: 'অ্যাপের ডেটা ডাউনলোড করতে সমস্যা হয়েছে। আবার চেষ্টা করুন');
      debugPrint("Data download error => $e");
    } finally {
      isLoading(false);
      if (Get.isDialogOpen ?? false) Get.back();
    }
  }

  bool _isDataStoredLocally() {
    // During selective updates, don't check for data completeness
    if (isSelectiveUpdate.value) {
      return true;
    }

    return categoryBox.values.isNotEmpty &&
        versesBox.values.isNotEmpty &&
        ruqyahsBox.values.isNotEmpty &&
        hijamasBox.values.isNotEmpty &&
        nirapottarDuaBox.values.isNotEmpty &&
        masnunDuaBox.values.isNotEmpty &&
        masnunDuaCategoriesBox.values.isNotEmpty &&
        masayelBox.values.isNotEmpty &&
        masayelCategoriesBox.values.isNotEmpty &&
        audioBox.values.isNotEmpty;
  }

  void _updateProgress({
    required String title,
    required String message,
    required double progress,
    DataType? currentDataType,
  }) {
    dataProgress.value = DataProgress(
      title: title,
      message: message,
      progress: progress.clamp(0.0, 1.0),
      currentDataType: currentDataType,
    );
  }

  Future<void> _showLoadingDialog() async {
    Get.defaultDialog(
      radius: 20,
      contentPadding: const EdgeInsets.all(20.0),
      title: '',
      titleStyle: primary20W500,
      content: Obx(() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dataProgress.value.title,
            style: primary20W500,
            textAlign: TextAlign.center,
          ),
          20.kH,
          AnimatedLiquidLinearProgressIndicator(
            progress: dataProgress.value.progress,
          ),
          15.kH,
          Text(
            '${(dataProgress.value.progress * 100).toInt()}%',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          15.kH,
          Text(
            dataProgress.value.message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      )),
      barrierDismissible: false,
    );
  }

  // Unified fetch method
  Future<void> _fetchSingleDataType(DataType dataType) async {
    try {
      switch (dataType) {
        case DataType.categories:
          await _fetchCategories();
          break;
        case DataType.verses:
          await _fetchVerses();
          break;
        case DataType.articles:
          await _fetchArticles();
          break;
        case DataType.hijamas:
          await _fetchHijamas();
          break;
        case DataType.masnunDuas:
          await _fetchMasnunDuas();
          break;
        case DataType.masnunDuaCategories:
          await _fetchMasnunDuaCategories();
          break;
        case DataType.nirapottarDuas:
          await _fetchNirapottarDuas();
          break;
        case DataType.audios:
          await _fetchAudios();
          break;
        case DataType.masayel:
          await _fetchMasayels();
          break;
        case DataType.masayelCategories:
          await _fetchMasayelCategories();
          break;
      }
    } catch (e) {
      debugPrint("Error fetching $dataType: $e");
      rethrow;
    }
  }

  // Individual fetch methods
  Future<void> _fetchCategories() async {
    final response = await CategoryService.getAllCategories();
    _responseData[DataType.categories] = List<Category>.from(
      response.data["categories"].map((e) => Category.fromJson(e)),
    );
  }

  Future<void> _fetchVerses() async {
    final response = await VersesService.getVerses();
    _responseData[DataType.verses] = List<Verse>.from(
      response.data["verses"].map((e) => Verse.fromJson(e)),
    );
  }

  Future<void> _fetchArticles() async {
    final response = await ArticlesService.getArticles();
    _responseData[DataType.articles] = List<Article>.from(
      response.data["articles"].map((e) => Article.fromJson(e)),
    );
  }

  Future<void> _fetchHijamas() async {
    final response = await HijamaService.getHijamaArticles();
    _responseData[DataType.hijamas] = List<Article>.from(
      response.data["hijamas"].map((e) => Article.fromJson(e)),
    );
  }

  Future<void> _fetchMasnunDuas() async {
    final response = await MasnunDuaService.getMasnunDuas();
    _responseData[DataType.masnunDuas] = List<MasnunDua>.from(
      response.data["masnunDuas"].map((e) => MasnunDua.fromJson(e)),
    );
  }

  Future<void> _fetchMasnunDuaCategories() async {
    final response = await MasnunDuaService.getMasnunDuaCategories();
    _responseData[DataType.masnunDuaCategories] = List<Category>.from(
      response.data["categories"].map((e) => Category.fromJson(e)),
    );
  }

  Future<void> _fetchNirapottarDuas() async {
    final response = await NirapottarDuaService.getNirapottarDuas();
    _responseData[DataType.nirapottarDuas] = List<Article>.from(
      response.data["nirapottarDuas"].map((e) => Article.fromJson(e)),
    );
  }

  Future<void> _fetchAudios() async {
    final response = await AudioService.getAllAudios();
    _responseData[DataType.audios] = List<AudioCategory>.from(
      response.data["audios"].map((e) => AudioCategory.fromJson(e)),
    );
  }

  Future<void> _fetchMasayels() async {
    final response = await MasnunDuaService.getMasayels();
    debugPrint("Masayels quantity: ${response.data["masayels"].length}");
    _responseData[DataType.masayel] = List<MasnunDua>.from(
      response.data["masayels"].map((e) => MasnunDua.fromJson(e)),
    );
  }

  Future<void> _fetchMasayelCategories() async {
    final response = await MasnunDuaService.getMasayelCategories();
    _responseData[DataType.masayelCategories] = List<Category>.from(
      response.data["categories"].map((e) => Category.fromJson(e)),
    );
  }

  // Clear methods
  Future<void> _clearAllBoxes() async {
    debugPrint("Clearing all hive boxes data");
    await Future.wait([
      categoryBox.clear(),
      versesBox.clear(),
      ruqyahsBox.clear(),
      hijamasBox.clear(),
      nirapottarDuaBox.clear(),
      masnunDuaBox.clear(),
      masnunDuaCategoriesBox.clear(),
      masayelBox.clear(),
      masayelCategoriesBox.clear(),
      audioBox.clear(),
    ]);
  }

  Future<void> _clearSingleBox(DataType dataType) async {
    switch (dataType) {
      case DataType.categories:
        await categoryBox.clear();
        break;
      case DataType.verses:
        await versesBox.clear();
        break;
      case DataType.articles:
        await ruqyahsBox.clear();
        break;
      case DataType.hijamas:
        await hijamasBox.clear();
        break;
      case DataType.masnunDuas:
        await masnunDuaBox.clear();
        break;
      case DataType.masnunDuaCategories:
        await masnunDuaCategoriesBox.clear();
        break;
      case DataType.nirapottarDuas:
        await nirapottarDuaBox.clear();
        break;
      case DataType.audios:
        await audioBox.clear();
        break;
      case DataType.masayel:
        await masayelBox.clear();
        break;
      case DataType.masayelCategories:
        await masayelCategoriesBox.clear();
        break;
    }
  }

  // Save methods
  Future<void> _saveAllDataToHive() async {
    final futures = DataType.values.map((dataType) => _saveSingleDataType(dataType));
    await Future.wait(futures);
  }

  Future<void> _saveSingleDataType(DataType dataType) async {
    final data = _responseData[dataType];
    if (data == null) return;

    switch (dataType) {
      case DataType.categories:
        await categoryBox.addAll(data as List<Category>);
        break;
      case DataType.verses:
        await versesBox.addAll(data as List<Verse>);
        break;
      case DataType.articles:
        await ruqyahsBox.addAll(data as List<Article>);
        break;
      case DataType.hijamas:
        await hijamasBox.addAll(data as List<Article>);
        break;
      case DataType.masnunDuas:
        await masnunDuaBox.addAll(data as List<MasnunDua>);
        break;
      case DataType.masnunDuaCategories:
        await masnunDuaCategoriesBox.addAll(data as List<Category>);
        break;
      case DataType.nirapottarDuas:
        await nirapottarDuaBox.addAll(data as List<Article>);
        break;
      case DataType.audios:
        await audioBox.addAll(data as List<AudioCategory>);
        break;
      case DataType.masayel:
        await masayelBox.addAll(data as List<MasnunDua>);
        break;
      case DataType.masayelCategories:
        await masayelCategoriesBox.addAll(data as List<Category>);
        break;
    }
  }

  // Getter methods for accessing data
  List<Category> get categories => _responseData[DataType.categories] ?? [];
  List<Verse> get verses => _responseData[DataType.verses] ?? [];
  List<Article> get articles => _responseData[DataType.articles] ?? [];
  List<Article> get hijamas => _responseData[DataType.hijamas] ?? [];
  List<MasnunDua> get masnunDuas => _responseData[DataType.masnunDuas] ?? [];
  List<Category> get masnunDuaCategories => _responseData[DataType.masnunDuaCategories] ?? [];
  List<Article> get nirapottarDuas => _responseData[DataType.nirapottarDuas] ?? [];
  List<AudioCategory> get audios => _responseData[DataType.audios] ?? [];
  List<MasnunDua> get masayels => _responseData[DataType.masayel] ?? [];
  List<Category> get masayelCategories => _responseData[DataType.masayelCategories] ?? [];

  // Debug method to check current data state
  void logCurrentDataState() {
    debugPrint("=== Current Data State ===");
    debugPrint("Categories in Hive: ${categoryBox.values.length}");
    debugPrint("Verses in Hive: ${versesBox.values.length}");
    debugPrint("Articles in Hive: ${ruqyahsBox.values.length}");
    debugPrint("Hijamas in Hive: ${hijamasBox.values.length}");
    debugPrint("MasnunDuas in Hive: ${masnunDuaBox.values.length}");
    debugPrint("MasnunDua Categories in Hive: ${masnunDuaCategoriesBox.values.length}");
    debugPrint("Nirapottar Duas in Hive: ${nirapottarDuaBox.values.length}");
    debugPrint("Audios in Hive: ${audioBox.values.length}");
    debugPrint("Masayels in Hive: ${masayelBox.values.length}");
    debugPrint("Masayel Categories in Hive: ${masayelCategoriesBox.values.length}");
    debugPrint("========================");
  }
}