import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: SCAFFOLD_BACKGROUND_COLOR,
    fontFamily: GoogleFonts.hindSiliguri().fontFamily,
    primaryColor: PRIMARY_COLOR,
    appBarTheme: AppBarTheme(
      backgroundColor: PRIMARY_COLOR,
      titleSpacing: 0,
      titleTextStyle:
      GoogleFonts.hindSiliguri(fontWeight: FontWeight.w700, fontSize: 20, color: WHITE),
      iconTheme: const IconThemeData(
        color: WHITE, //change your color here
      ),
    ),
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
}
