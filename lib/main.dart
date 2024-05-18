import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/helper/Theme.dart';
import 'package:rukiyah_and_ayat/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: MyTheme.lightTheme,
    );
  }
}
