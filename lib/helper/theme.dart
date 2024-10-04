import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: WHITE,
    canvasColor: SCAFFOLD_BACKGROUND_COLOR,
    fontFamily: GoogleFonts.hindSiliguri().fontFamily,
    primaryColor: PRIMARY_COLOR,
    cardColor: WHITE,
    indicatorColor: PRIMARY_COLOR_LIGHT,
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      backgroundColor: PRIMARY_COLOR,
      titleSpacing: 0,
      titleTextStyle: GoogleFonts.hindSiliguri(
          fontWeight: FontWeight.w700, fontSize: 20, color: WHITE),
      iconTheme: const IconThemeData(
        color: WHITE, //change your color here
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
    scaffoldBackgroundColor: DARK_SCAFFOLD_BACKGROUND_COLOR,
    canvasColor: DARK_SCAFFOLD_BACKGROUND_COLOR,
    fontFamily: GoogleFonts.hindSiliguri().fontFamily,
    primaryColor: BLACK,
    cardColor: BLACK,
    indicatorColor: BLACK,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      backgroundColor: BLACK,
      titleSpacing: 0,
      titleTextStyle: GoogleFonts.hindSiliguri(
          fontWeight: FontWeight.w700, fontSize: 20, color: WHITE),
      iconTheme: const IconThemeData(
        color: WHITE, //change your color here
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