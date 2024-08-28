import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Screen.dart';
import 'package:rukiyah_and_ayat/pages/ayat/ayat_categories.dart';
import 'package:rukiyah_and_ayat/pages/under_development.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/services/version_service.dart';
import 'package:rukiyah_and_ayat/utils/common_functions.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/buttons/primary_button.dart';
import 'package:rukiyah_and_ayat/widgets/cards/screen_card.dart';
import 'package:rukiyah_and_ayat/widgets/dialogs/confirmation_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Screen> screens = [
    Screen(
      'আয়াত',
      FlutterIslamicIcons.quran,
      categorySection,
    ),
    Screen(
      'অডিও',
      PhosphorIcons.music_notes_thin,
      underDevelopment,
    ),
    Screen(
      'রুকইয়াহ',
      PhosphorIcons.first_aid_kit_thin,
      underDevelopment,
    ),
    Screen(
      'হিজামা',
      PhosphorIcons.first_aid_thin,
      underDevelopment,
    ),
    Screen(
      'নিরাপত্তার দুআ',
      PhosphorIcons.shield_plus_thin,
      underDevelopment,
    ),
    Screen(
      'মাসনুন দুআ',
      FlutterIslamicIcons.tasbihHand,
      underDevelopment,
    ),
    Screen(
      'মাসায়েল',
      PhosphorIcons.question_thin,
      underDevelopment,
    ),
    Screen(
      'বিবিধ',
      PhosphorIcons.bookmarks_thin,
      underDevelopment,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAppVersion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Text(
            "রুকইয়াহ ও আয়াত",
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              decoration: rounded20Primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    FlutterIslamicIcons.quran2,
                    color: WHITE,
                    size: 50,
                  ),
                  24.kH,
                  Text(
                      "وَ نُنَزِّلُ مِنَ الۡقُرۡاٰنِ مَا هُوَ شِفَآءٌ وَّ رَحۡمَۃٌ لِّلۡمُؤۡمِنِیۡنَ",
                      textAlign: TextAlign.center,
                      style: white16W600Arabic),
                  verticalGap12,
                  Text(
                      "আর আমি নাযিল করেছি এমন কুরআন, যা মুমিনের জন্য আরোগ্য ও রহমতস্বরূপ",
                      textAlign: TextAlign.center,
                      style: white16W600),
                  verticalGap12,
                  Text("“সূরাঃ আল-ইসরা (১৭ঃ৮২)”",
                      textAlign: TextAlign.center, style: white14W500),
                ],
              ),
            ),
            16.kH,
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
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
            PrimaryButton(
                label: "ওয়েবসাইট ভিজিট করুন",
                onTap: () {
                  launchInBrowser(Uri.parse(WEBSITE_URL));
                }),
          ],
        ),
      ),
    );
  }

  void checkAppVersion() async {
    final response = await VersionService.getAppVersion();

    var jsonResponse = response.data as Map<String, dynamic>;
    final box = GetStorage();

    String currentAppVersion = jsonResponse["payload"]["version"];

    String? prevAppVersion = box.read("appVersion");
    if (prevAppVersion != null && prevAppVersion != currentAppVersion) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showCustomDialog();
      });
    }
    box.write("appVersion", currentAppVersion);
  }

  void showCustomDialog() {
    showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: "নতুন আপডেট",
          confirmationMessage: 'অ্যাপের নতুন আপডেট পাওয়া গেছে!',
          cancelText: 'বাতিল',
          okText: "আপডেট করুন",
          onOkPressed: () {
            Get.back();
            _launchURL(
                'https://play.google.com/store/apps/details?id=us.palooi&hl=bn&gl=US');
          },
        );
      },
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }
}
