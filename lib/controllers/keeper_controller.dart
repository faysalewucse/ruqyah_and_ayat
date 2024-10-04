import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/storage_controller.dart';

class KeeperController extends GetxController {
  final storageController = Get.find<StorageController>();

  late Rx<String> arabicFontFamily;
  late Rx<double> arabicFontSize;
  late Rx<ThemeMode> currentTheme;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ThemeMode themeMode = storageController.getThemeMode() == "light" ? ThemeMode.light : ThemeMode.dark;
    currentTheme = themeMode.obs;
    arabicFontFamily = storageController.getDefaultFontFamily().obs;
    arabicFontSize = storageController.getDefaultFontSize().obs;
  }
  // function to switch between themes
  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    storageController.saveThemeMode(currentTheme.value == ThemeMode.light ? "light" : "dark");
    currentTheme.refresh();
  }

}