import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class KeeperController extends GetxController {
  final ayatListFontFamily = "AlMajeed".obs;
  Rx<ThemeMode> currentTheme = ThemeMode.light.obs;

  // function to switch between themes
  void switchTheme() {
    currentTheme.value = currentTheme.value == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    currentTheme.refresh();
  }

}