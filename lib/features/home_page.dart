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
import 'package:rukiyah_and_ayat/models/Config.dart' as conf;
import 'package:rukiyah_and_ayat/models/Screen.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/services/version_service.dart';
import 'package:rukiyah_and_ayat/utils/common_functions.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_images.dart';
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
            icon: screen.iconString,
            title: screen.name,
            onTap: () => _navigateToScreen(screen.route),
          ),
        )
        .toList();
  }

  List<Widget> _getActionMenuItems(BuildContext context) {
    return [
      _buildDrawerMenuOthersItem(
        context: context,
        icon: PhosphorIcons.warning_circle_thin,
        title: 'সমস্যা জানান',
        onTap: () => launchInBrowser(ApiUrls.reportProblemGoogleForm),
      ),
      _buildDrawerMenuOthersItem(
        context: context,
        icon: PhosphorIcons.share_network_thin,
        title: 'শেয়ার করুন',
        onTap: () => _shareApp(context),
      ),
      _buildDrawerMenuOthersItem(
        context: context,
        icon: PhosphorIcons.google_play_logo_thin,
        title: 'আরো অ্যাপ দেখুন',
        onTap: () => launchInBrowser(ApiUrls.yaqeenTechSolutionsPlayStoreUrl),
      ),
    ];
  }

  Widget _buildDrawerMenuItem({
    required BuildContext context,
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      dense: true,
      leading: Image.asset(icon),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).textTheme.titleLarge?.color),
      ),
      onTap: onTap,
    );
  }
  
  Widget _buildDrawerMenuOthersItem({
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
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: rounded20,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Vector UI Elements - Top Right Large Circle
          Positioned(
            top: -30,
            right: -30,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.12),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.15),
                  width: 2,
                ),
              ),
            ),
          ),
          // Vector UI Elements - Bottom Left Medium Circle
          Positioned(
            bottom: -40,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          // Vector UI Elements - Top Right Small Inner Circle
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
            ),
          ),
          // Vector UI Elements - Bottom Right Corner Arc
          Positioned(
            bottom: -20,
            right: 20,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.white.withValues(alpha: 0.06),
              ),
            ),
          ),
          // Vector UI Elements - Top Left Dot Pattern
          Positioned(
            top: 20,
            left: 20,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(8),
                6.kW,
                _buildDot(8),
                6.kW,
                _buildDot(8),
              ],
            ),
          ),
          // Vector UI Elements - Bottom Left Small Dots
          Positioned(
            bottom: 25,
            left: 25,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildDot(6, opacity: 0.4),
                5.kW,
                _buildDot(6, opacity: 0.3),
                5.kW,
                _buildDot(6, opacity: 0.2),
              ],
            ),
          ),
          // Vector UI Elements - Top Right Progress Lines
          Positioned(
            top: 25,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 35,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                6.kH,
                Container(
                  width: 25,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                6.kH,
                Container(
                  width: 15,
                  height: 3,
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          // Vector UI Elements - Floating Triangle Top Left
          Positioned(
            top: 50,
            left: -10,
            child: CustomPaint(
              size: const Size(20, 20),
              painter: _TrianglePainter(
                color: AppColors.white.withValues(alpha: 0.15),
              ),
            ),
          ),
          // Vector UI Elements - Plus Sign Decoration
          Positioned(
            bottom: 50,
            right: 30,
            child: CustomPaint(
              size: const Size(16, 16),
              painter: _PlusPainter(
                color: AppColors.white.withValues(alpha: 0.25),
              ),
            ),
          ),
          // Content
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
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
          ),
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
      Screen('আয়াত', AppImages.ayatImage, categorySection),
      Screen('রুকইয়াহ', AppImages.ruqyahImage, ruqyah),
      Screen('হিজামা', AppImages.hijamaImage, hijama),
      Screen('সুরক্ষার আমল', AppImages.protectionImage, securityDua),
      Screen('অডিও', AppImages.audioImage, audioCategories),
      Screen('মাসায়েল', AppImages.masayelImage, masayel),
      Screen('মাসনুন দুআ', AppImages.masnunDuaImage, masnunDuaCategories),
      Screen('বিবিধ', AppImages.bibidhlImage, bibidh),
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
      final response = await VersionService.getAppConfig();
      final configs = response.data["configs"] as List<dynamic>;
      final latestConfig = conf.Config.fromJson(configs.first);

      _dataController.currentAppVersion.value = packageInfo.version;

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

  // Helper method to build decorative dots
  Widget _buildDot(double size, {double opacity = 0.5}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.white.withValues(alpha: opacity),
      ),
    );
  }
}

// Custom Triangle Painter
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Plus Sign Painter
class _PlusPainter extends CustomPainter {
  final Color color;

  _PlusPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    // Horizontal line
    canvas.drawLine(
      Offset(centerX - 4, centerY),
      Offset(centerX + 4, centerY),
      paint,
    );

    // Vertical line
    canvas.drawLine(
      Offset(centerX, centerY - 4),
      Offset(centerX, centerY + 4),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
