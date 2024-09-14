import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/controllers/storage_controller.dart';

class KeeperController extends GetxController {
  final storageController = Get.find<StorageController>();

  final ayatListFontFamily = "AlMajeed".obs;
  late Rx<ThemeMode> currentTheme;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ThemeMode themeMode = storageController.getThemeMode() == "light" ? ThemeMode.light : ThemeMode.dark;
    currentTheme = themeMode.obs;
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