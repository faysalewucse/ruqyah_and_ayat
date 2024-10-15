import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    canvasColor: AppColors.scaffoldBackgroundColor,
    fontFamily: GoogleFonts.hindSiliguri().fontFamily,
    primaryColor: AppColors.primaryColor,
    cardColor: AppColors.white,
    indicatorColor: AppColors.primaryColorLight,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      titleSpacing: 0,
      titleTextStyle: GoogleFonts.hindSiliguri(
          fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.white),
      iconTheme: const IconThemeData(
        color: AppColors.white, //change your color here
      ),
    ),
    sliderTheme: SliderThemeData(overlayShape: SliderComponentShape.noOverlay),
    textTheme: TextTheme(
      bodySmall: n30014Normal,
      bodyMedium: n30014W500,
      bodyLarge: n30016W500,
      labelLarge: n30022Normal,
      labelMedium: n70012Normal,
      labelSmall: n70012W500,
      displayLarge: n70016W500,
      displayMedium: n70014W500,
      displaySmall: n70014Normal,
      titleLarge: n70024W500,
      titleMedium: e50016W500,
      titleSmall: n70018Normal,
      headlineLarge: n70020W500,
      headlineMedium: white18Normal,
      headlineSmall: primary14W500,
    ),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkScaffoldBackgroundColor,
    canvasColor: AppColors.darkScaffoldBackgroundColor,
    fontFamily: GoogleFonts.hindSiliguri().fontFamily,
    primaryColor: AppColors.black,
    cardColor: AppColors.black,
    indicatorColor: AppColors.black,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.black,
      titleSpacing: 0,
      titleTextStyle: GoogleFonts.hindSiliguri(
          fontWeight: FontWeight.w700, fontSize: 20, color: AppColors.white),
      iconTheme: const IconThemeData(
        color: AppColors.white, //change your color here
      ),
    ),
    textTheme: TextTheme(
      bodySmall: n30014Normal.copyWith(color: Colors.white),
      bodyMedium: n30014W500.copyWith(color: Colors.white),
      bodyLarge: n30016W500.copyWith(color: Colors.white),
      labelLarge: n30022Normal.copyWith(color: Colors.white),
      labelMedium: n70012Normal.copyWith(color: Colors.white),
      labelSmall: n70012W500.copyWith(color: Colors.white),
      displayLarge: n70016W500.copyWith(color: Colors.white),
      displayMedium: n70014W500.copyWith(color: Colors.white),
      displaySmall: n70014Normal.copyWith(color: Colors.white),
      titleLarge: n70024W500.copyWith(color: Colors.white),
      titleMedium: e50016W500.copyWith(color: Colors.white),
      titleSmall: n70018Normal.copyWith(color: Colors.white),
      headlineLarge: n70020W500.copyWith(color: Colors.white),
      headlineMedium: white18Normal.copyWith(color: Colors.white),
      headlineSmall: primary14W500.copyWith(color: Colors.white),
    ),
  );
}