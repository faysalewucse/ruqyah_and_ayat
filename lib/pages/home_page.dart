import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/controllers/data_controller.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Config.dart';
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
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

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
      'অডিও',
      PhosphorIcons.music_notes_thin,
      audio,
    ),
    Screen(
      'নিরাপত্তার দুআ',
      PhosphorIcons.shield_plus_thin,
      securityDua,
    ),
    Screen(
      'মাসনুন দুআ',
      FlutterIslamicIcons.tasbihHand,
      masnunDua,
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
        title: const Padding(
          padding: EdgeInsets.only(left: 18.0),
          child: Text(
            appName,
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 10),
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 200.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/icons/dua.png",
                      width: deviceHeight * 0.08,
                    ),
                    Text(
                      appName,
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            ...screens.map(
              (Screen screen) => ListTile(
                leading: Icon(
                  screen.iconData,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
                title: Text(screen.name),
                onTap: () {
                  Get.back();
                  Get.toNamed(screen.route);
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(PhosphorIcons.warning_circle),
              title: const Text('Report Problem'),
              onTap: () {
                launchInBrowser(reportProblemGoogleForm);
              },
            ),
            ListTile(
              leading: const Icon(PhosphorIcons.share_network),
              title: const Text('Share'),
              onTap: () {
                _onShare(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.apps),
              title: const Text('More Apps'),
              onTap: () {
                launchInBrowser(yaqeenTechSolutionsPlayStoreUrl);
              },
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
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: rounded20),
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
                  const Text(
                    "وَ نُنَزِّلُ مِنَ الۡقُرۡاٰنِ مَا هُوَ شِفَآءٌ وَّ رَحۡمَۃٌ لِّلۡمُؤۡمِنِیۡنَ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "AlMushaf",
                      color: WHITE,
                      fontSize: 24,
                    ),
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

        if (latestConfig.dataVersion != dataVersion) {
          await dataController.updateData();
        }

        if (packageInfo.version != latestConfig.appVersion) {
          showAppUpdateDialog();
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
          title: "নতুন আপডেট",
          confirmationMessage: 'অ্যাপের নতুন আপডেট পাওয়া গেছে!',
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
