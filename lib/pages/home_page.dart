import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/pages/audio/audio.dart';
import 'package:rukiyah_and_ayat/pages/ayat/ayat_categories.dart';
import 'package:rukiyah_and_ayat/widgets/cards/screen_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Screen> screens = [
    Screen('আয়াত', FlutterIslamicIcons.quran, () => const AyatCategories()),
    Screen('অডিও', Icons.audiotrack, () => const AyatCategories()),
    Screen('রুকইয়াহ', Icons.health_and_safety, () => const AyatCategories()),
    Screen('হিজামা', Icons.local_hospital, () => const AyatCategories()),
    Screen('নিরাপত্তার দুআ', Icons.local_hospital_outlined, () => const AyatCategories()),
    Screen('মাসনুন দুআ', Icons.settings_system_daydream, () => const AyatCategories()),
    Screen('মাসায়েল/ফাতওয়া', Icons.question_answer, () => const AyatCategories()),
    Screen('বিবিধ', Icons.bookmark_added_rounded, () => const AyatCategories()),
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
                itemCount: screens.length,
                itemBuilder: (context, index) {
                  return ScreenCard(
                    screen: screens[index],
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
