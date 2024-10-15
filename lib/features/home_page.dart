import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/controllers/data_controller.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Config.dart';
import 'package:rukiyah_and_ayat/models/Screen.dart';
import 'package:rukiyah_and_ayat/features/ayat/ayat_categories.dart';
import 'package:rukiyah_and_ayat/features/under_development.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/services/version_service.dart';
import 'package:rukiyah_and_ayat/utils/common_functions.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/animated_progress_loader.dart';
import 'package:rukiyah_and_ayat/widgets/buttons/primary_button.dart';
import 'package:rukiyah_and_ayat/widgets/cards/screen_card.dart';
import 'package:rukiyah_and_ayat/widgets/dialogs/confirmation_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _keeperController = Get.find<KeeperController>();
  final networkController = Get.find<NetworkController>();
  final dataController = Get.find<DataController>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Screen> screens = [
    Screen(
      'আয়াত',
      FlutterIslamicIcons.quran,
      categorySection,
    ),
    Screen(
      'রুকইয়াহ',
      PhosphorIcons.first_aid_kit_thin,
      ruqyah,
    ),
    Screen(
      'হিজামা',
      PhosphorIcons.first_aid_thin,
      hijama,
    ),
    Screen(
      'হেফাজতের মাসনুন আমল',
      PhosphorIcons.shield_thin,
      securityDua,
    ),
    Screen(
      'মাসনুন দুআ',
      FlutterIslamicIcons.tasbihHand,
      masnunDuaCategories,
    ),
    Screen(
      'অডিও',
      PhosphorIcons.music_notes_thin,
      audioCategories,
    ),
    Screen(
      'মাসায়েল',
      PhosphorIcons.question_thin,
      masayel,
    ),
    Screen(
      'বিবিধ',
      PhosphorIcons.bookmarks_thin,
      bibidh,
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (networkController.hasConnection.isTrue) {
      checkAppVersion();
    }
  }

  @override
  void dispose() {
    _keeperController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text(
          appName,
        ),
        actions: [
          IconButton(
            onPressed: () {
              _keeperController.switchTheme();
              Get.changeThemeMode(_keeperController.currentTheme.value);
            },
            icon: Obx(
              () => Icon(
                _keeperController.currentTheme.value == ThemeMode.dark
                    ? PhosphorIcons.sun
                    : PhosphorIcons.moon,
              ),
            ),
          )
        ],
        leading: IconButton(
          icon: const Icon(PhosphorIcons.list),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              width: deviceWidth,
              height: 200.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Image.asset(
                        _keeperController.currentTheme.value == ThemeMode.dark
                            ? "assets/icons/app_icon_dark.png"
                            : "assets/icons/app_icon.png",
                        width: deviceHeight * 0.08,
                      ),
                    ),
                    8.kH,
                    Text(
                      appName,
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  ...screens.map(
                    (Screen screen) => ListTile(
                      dense: true,
                      leading: Icon(
                        screen.iconData,
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                      title: Text(
                        screen.name,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      onTap: () {
                        Get.back();
                        Get.toNamed(screen.route);
                      },
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    dense: true,
                    leading: Icon(
                      PhosphorIcons.warning_circle_thin,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    title: Text(
                      'সমস্যা জানান',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onTap: () {
                      launchInBrowser(reportProblemGoogleForm);
                    },
                  ),
                  ListTile(
                    dense: true,
                    leading: Icon(
                      PhosphorIcons.share_network_thin,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    title: Text(
                      'শেয়ার করুন',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onTap: () {
                      _onShare(context);
                    },
                  ),
                  ListTile(
                    dense: true,
                    leading: Icon(
                      PhosphorIcons.google_play_logo_thin,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                    title: Text(
                      'আরো অ্যাপ দেখুন',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    onTap: () {
                      launchInBrowser(yaqeenTechSolutionsPlayStoreUrl);
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Text(
                    "Powered by",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "YAQEEN TECH SOLUTIONS",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        color: Theme.of(context).canvasColor,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: rounded20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // const Icon(
                      //   FlutterIslamicIcons.quran2,
                      //   color: AppColors.white,
                      //   size: 50,
                      // ),
                      // 24.kH,
                      const Text(
                        "وَ نُنَزِّلُ مِنَ الۡقُرۡاٰنِ مَا هُوَ شِفَآءٌ وَّ رَحۡمَۃٌ لِّلۡمُؤۡمِنِیۡنَ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "NooreHuda",
                            color: AppColors.white,
                            fontSize: 26,
                            letterSpacing: 0),
                      ),
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
              ],
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
                launchInBrowser(WEBSITE_URL);
              },
            ),
          ],
        ),
      ),
    );
  }

  _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      playStoreAppLink,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  void checkAppVersion() async {
    try {
      final response = await VersionService.getAppConfig();

      List<dynamic> jsonResponse = response.data["configs"] as List<dynamic>;
      List<Config> configs =
          jsonResponse.map((json) => Config.fromJson(json)).toList();

      if (configs.isNotEmpty) {
        Config latestConfig = configs.first;

        final box = GetStorage();
        String dataVersion =
            box.read("dataVersion") ?? latestConfig.dataVersion;

        if (packageInfo.version != latestConfig.appVersion) {
          showAppUpdateDialog();
        } else if (latestConfig.dataVersion != dataVersion) {
          await dataController.updateData();
        }

        box.write("dataVersion", latestConfig.dataVersion);
      }
    } catch (error) {
      print("Error checking app version or data: $error");
    }
  }

  void showAppUpdateDialog() {
    showDialog<void>(
      context: Get.context!,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: "অ্যাপ আপডেট",
          confirmationMessage:
              'নতুন সব বৈশিষ্ট্য এবং উন্নত পারফরম্যান্স পেতে এখনই আপনার অ্যাপটি আপডেট করুন।',
          cancelText: 'বাতিল',
          okText: "আপডেট করুন",
          onOkPressed: () {
            Get.back();
            launchInBrowser(playStoreAppLink);
          },
        );
      },
    );
  }
}
