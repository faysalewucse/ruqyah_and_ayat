import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

class MyTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: SCAFFOLD_BACKGROUND_COLOR,
    primaryColor: PRIMARY_COLOR,
    appBarTheme: AppBarTheme(
      backgroundColor: WHITE,
      titleSpacing: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontFamily: GoogleFonts.tiroBangla().fontFamily,
        fontWeight: FontWeight.w900,
        color: BLACK,
      ),
    ),
    fontFamily: GoogleFonts.tiroBangla().fontFamily,
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
