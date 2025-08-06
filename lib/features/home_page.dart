import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/controllers/data_controller/data_controller.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Config.dart';
import 'package:rukiyah_and_ayat/models/Screen.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/services/version_service.dart';
import 'package:rukiyah_and_ayat/utils/common_functions.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/buttons/primary_button.dart';
import 'package:rukiyah_and_ayat/widgets/cards/screen_card.dart';
import 'package:rukiyah_and_ayat/widgets/dialogs/confirmation_dialog.dart';
import 'package:share_plus/share_plus.dart';

import '../utils/constants/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Controllers
  late final KeeperController _keeperController;
  late final NetworkController _networkController;
  late final DataController _dataController;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _checkAppVersionIfConnected();
  }

  void _initializeControllers() {
    _keeperController = Get.find<KeeperController>();
    _networkController = Get.find<NetworkController>();
    _dataController = Get.find<DataController>();
  }

  void _checkAppVersionIfConnected() async {
    await _dataController.initDataController();

    if (_networkController.hasConnection.isTrue) {
      _checkAppVersion();
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
      appBar: _buildAppBar(),
      drawer: _buildDrawer(context),
      body: SafeArea(child: _buildBody(context)),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      titleSpacing: 0,
      title: const Text(appName),
      actions: [_buildThemeToggleButton()],
      leading: _buildDrawerButton(),
    );
  }

  Widget _buildThemeToggleButton() {
    return IconButton(
      onPressed: _toggleTheme,
      icon: Obx(
        () => Icon(_keeperController.currentTheme.value == ThemeMode.dark ? PhosphorIcons.sun : PhosphorIcons.moon),
      ),
    );
  }

  Widget _buildDrawerButton() {
    return IconButton(icon: const Icon(PhosphorIcons.list), onPressed: () => _scaffoldKey.currentState?.openDrawer());
  }

  void _toggleTheme() {
    _keeperController.switchTheme();
    Get.changeThemeMode(_keeperController.currentTheme.value);
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(context),
          _buildDrawerMenuItems(context),
          const Divider(),
          _buildDrawerFooter(context),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader(BuildContext context) {
    TextStyle style = TextStyle(fontFamily: GoogleFonts.lexend().fontFamily, fontSize: 10, color: AppColors.white);

    return SizedBox(
      width: deviceWidth,
      height: 220.0,
      child: DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppIcon(),
            8.kH,
            Text(appName, style: Theme.of(context).appBarTheme.titleTextStyle),
            Obx(
              () =>
                  _dataController.currentAppVersion.value.isEmpty
                      ? Text("loading...", style: style)
                      : Text("v${_dataController.currentAppVersion.value}", style: style),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppIcon() {
    return Obx(
      () => Image.asset(
        _keeperController.currentTheme.value == ThemeMode.dark
            ? "assets/icons/app_icon_dark.png"
            : "assets/icons/app_icon.png",
        width: deviceHeight * 0.08,
      ),
    );
  }

  Widget _buildDrawerMenuItems(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [..._getScreenMenuItems(context), const Divider(), ..._getActionMenuItems(context)],
      ),
    );
  }

  List<Widget> _getScreenMenuItems(BuildContext context) {
    return _getScreens()
        .map(
          (screen) => _buildDrawerMenuItem(
            context: context,
            icon: screen.iconData,
            title: screen.name,
            onTap: () => _navigateToScreen(screen.route),
          ),
        )
        .toList();
  }

  List<Widget> _getActionMenuItems(BuildContext context) {
    return [
      _buildDrawerMenuItem(
        context: context,
        icon: PhosphorIcons.warning_circle_thin,
        title: 'সমস্যা জানান',
        onTap: () => launchInBrowser(ApiUrls.reportProblemGoogleForm),
      ),
      _buildDrawerMenuItem(
        context: context,
        icon: PhosphorIcons.share_network_thin,
        title: 'শেয়ার করুন',
        onTap: () => _shareApp(context),
      ),
      _buildDrawerMenuItem(
        context: context,
        icon: PhosphorIcons.google_play_logo_thin,
        title: 'আরো অ্যাপ দেখুন',
        onTap: () => launchInBrowser(ApiUrls.yaqeenTechSolutionsPlayStoreUrl),
      ),
    ];
  }

  Widget _buildDrawerMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: Theme.of(context).textTheme.titleLarge?.color),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).textTheme.titleLarge?.color),
      ),
      onTap: onTap,
    );
  }

  void _navigateToScreen(String route) {
    Get.back();
    Get.toNamed(route);
  }

  Widget _buildDrawerFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Text(
            "Powered by",
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(fontFamily: GoogleFonts.lexend().fontFamily, fontSize: 10),
            textAlign: TextAlign.center,
          ),
          Text(
            "devsKafela",
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontFamily: GoogleFonts.lexend().fontFamily,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildHeaderQuote(context), 16.kH, _buildScreenGrid(), verticalGap12, _buildWebsiteButton()],
      ),
    );
  }

  Widget _buildHeaderQuote(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: rounded20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "وَ نُنَزِّلُ مِنَ الۡقُرۡاٰنِ مَا هُوَ شِفَآءٌ وَّ رَحۡمَۃٌ لِّلۡمُؤۡمِنِیۡنَ",
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "NooreHuda", color: AppColors.white, fontSize: 26, letterSpacing: 0),
          ),
          verticalGap12,
          Text(
            "আর আমি নাযিল করেছি এমন কুরআন, যা মুমিনের জন্য আরোগ্য ও রহমতস্বরূপ",
            textAlign: TextAlign.center,
            style: white16W600,
          ),
          verticalGap12,
          Text("সূরাঃ আল-ইসরা (১৭ঃ৮২)", textAlign: TextAlign.center, style: white14W500),
        ],
      ),
    );
  }

  Widget _buildScreenGrid() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: _getScreens().length,
        itemBuilder: (context, index) => ScreenCard(screen: _getScreens()[index]),
      ),
    );
  }

  Widget _buildWebsiteButton() {
    return PrimaryButton(label: "ওয়েবসাইট ভিজিট করুন", onTap: () => launchInBrowser(ApiUrls.websiteUrl));
  }

  List<Screen> _getScreens() {
    return [
      Screen('আয়াত', FlutterIslamicIcons.quran, categorySection),
      Screen('রুকইয়াহ', PhosphorIcons.first_aid_kit_thin, ruqyah),
      Screen('হিজামা', PhosphorIcons.first_aid_thin, hijama),
      Screen('সুরক্ষার আমল', PhosphorIcons.shield_thin, securityDua),
      Screen('অডিও', PhosphorIcons.music_notes_thin, audioCategories),
      Screen('মাসায়েল', PhosphorIcons.question_thin, masayel),
      Screen('মাসনুন দুআ', FlutterIslamicIcons.tasbihHand, masnunDuaCategories),
      Screen('বিবিধ', PhosphorIcons.bookmarks_thin, bibidh),
    ];
  }

  Future<void> _shareApp(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      await Share.share(ApiUrls.playStoreAppLink, sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  Future<void> _checkAppVersion() async {
    try {
      print("[Config Called start]");
      final response = await VersionService.getAppConfig();
      final configs = response.data["configs"] as List<dynamic>;
      final latestConfig = Config.fromJson(configs.first);
      print("[Config Called end]");

      debugPrint("latest_config => [${latestConfig.toJson()}]");
      _dataController.currentAppVersion.value = packageInfo.version;

      print("current_app_version => [${packageInfo.buildNumber}]");
      print("latest_app_version => [${latestConfig.appVersion}]");

      if (packageInfo.buildNumber != latestConfig.appVersion) {
        _showAppUpdateDialog();
      } else {
        await _dataController.checkAndUpdateData(latestConfig);
      }
    } catch (error) {
      debugPrint("Error checking app version or data: $error");
    }
  }

  void _showAppUpdateDialog() {
    showDialog<void>(
      context: Get.context!,
      builder:
          (context) => ConfirmationDialog(
            title: "অ্যাপ আপডেট",
            confirmationMessage: 'নতুন সব বৈশিষ্ট্য এবং উন্নত পারফরম্যান্স পেতে এখনই আপনার অ্যাপটি আপডেট করুন।',
            cancelText: 'বাতিল',
            okText: "আপডেট করুন",
            onOkPressed: () {
              Get.back();
              launchInBrowser(ApiUrls.playStoreAppLink);
            },
          ),
    );
  }
}
