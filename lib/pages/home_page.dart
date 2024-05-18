import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/pages/audio/audio.dart';
import 'package:rukiyah_and_ayat/pages/ayat/ayat.dart';
import 'package:rukiyah_and_ayat/widgets/cards/category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Category> categories = [
    Category('আয়াত', FlutterIslamicIcons.quran, () => AyatPage()),
    Category('অডিও', Icons.audiotrack, () => AudioPage()),
    Category('রুকইয়াহ', Icons.health_and_safety, () => AyatPage()),
    Category('হিজামা', Icons.local_hospital, () => AyatPage()),
    Category('নিরাপত্তার দুআ', Icons.local_hospital_outlined, () => AyatPage()),
    Category('মাসনুন দুআ', Icons.settings_system_daydream, () => AyatPage()),
    Category('মাসায়েল/ফাতওয়া', Icons.question_answer, () => AyatPage()),
    Category('বিবিধ', Icons.bookmark_added_rounded, () => AyatPage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu_outlined),
        title: const Text("দুআ ও রুকইয়াহ",),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: categories[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
