import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
    theme: ThemeData(
      fontFamily: GoogleFonts.hindSiliguri().fontFamily,
      scaffoldBackgroundColor: Colors.indigo[500],
      cardColor: Colors.indigo[800],
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.white
      ),
    ),
  ));
}
