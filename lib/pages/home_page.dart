import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert' as convert;
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/pages/audio/audio.dart';
import 'package:rukiyah_and_ayat/pages/ayat/ayat_categories.dart';
import 'package:rukiyah_and_ayat/pages/under_development.dart';
import 'package:rukiyah_and_ayat/widgets/buttons/primary_button.dart';
import 'package:rukiyah_and_ayat/widgets/cards/screen_card.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Screen> screens = [
    Screen('আয়াত', FlutterIslamicIcons.quran, () => const AyatCategories()),
    Screen('অডিও', Icons.audiotrack_outlined, () => const UnderDevelopment()),
    Screen('রুকইয়াহ', Icons.health_and_safety_outlined, () => const UnderDevelopment()),
    Screen('হিজামা', Icons.local_hospital_outlined, () => const UnderDevelopment()),
    Screen('নিরাপত্তার দুআ', Icons.shield_moon_outlined, () => const UnderDevelopment()),
    Screen('মাসনুন দুআ', FlutterIslamicIcons.tasbihHand, () => const UnderDevelopment()),
    Screen('মাসায়েল', Icons.question_answer_outlined, () => const UnderDevelopment()),
    Screen('বিবিধ', Icons.bookmark_added_outlined, () => const UnderDevelopment()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAppVersion();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("দুআ ও রুকইয়াহ",),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              decoration: rounded6Primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("وَ نُنَزِّلُ مِنَ الۡقُرۡاٰنِ مَا هُوَ شِفَآءٌ وَّ رَحۡمَۃٌ لِّلۡمُؤۡمِنِیۡنَ", textAlign: TextAlign.center, style: white18W600),
                  verticalGap12,
                  Text("আর আমি কুরআন নাযিল করি যা মুমিনদের জন্য শিফা ও রহমত", textAlign: TextAlign.center, style: white18W600,),
                  verticalGap12,
                  Text("“সূরাঃ আল-ইসরা (১৭ঃ৮২)”", textAlign: TextAlign.center, style: white14W500),
                ],
              ),
            ),
            verticalGap12,
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                itemCount: screens.length,
                itemBuilder: (context, index) {
                  return ScreenCard(
                    screen: screens[index],
                  );
                },
              ),
            ),
            verticalGap12,
            PrimaryButton(label: "ওয়েবসাইট ভিজিট করুন", onTap: (){
              _launchInBrowser(Uri.parse("https://sunnahcurebd.com/"));
            },)
          ],
        ),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  checkAppVersion() async {
    final response = await http.get(Uri.parse("http://192.168.0.106:10000/api/v1"));
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    final box = GetStorage();

    String currentAppVersion = jsonResponse["payload"]["version"];
    String? prevAppVersion = box.read("appVersion");
    if(prevAppVersion != null && prevAppVersion != currentAppVersion){

    }
    box.write("appVersion", currentAppVersion);
  }
}
