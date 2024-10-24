import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rukiyah_and_ayat/api/firebase_api.dart';
import 'package:rukiyah_and_ayat/bindings.dart';
import 'package:rukiyah_and_ayat/controllers/data_controller/data_controller.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';
import 'package:rukiyah_and_ayat/controllers/network_controller.dart';
import 'package:rukiyah_and_ayat/controllers/storage_controller.dart';
import 'package:rukiyah_and_ayat/firebase_options.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/helper/hive_boxes.dart';
import 'package:rukiyah_and_ayat/utils/constants/app_theme.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/models/audio/audio.dart';
import 'package:rukiyah_and_ayat/models/audio/audio_category.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';
import 'package:rukiyah_and_ayat/router/Routers.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotification();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  await Hive.initFlutter();

  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(VerseAdapter());
  Hive.registerAdapter(ArticleAdapter());
  Hive.registerAdapter(MasnunDuaAdapter());
  Hive.registerAdapter(AudioAdapter());
  Hive.registerAdapter(AudioCategoryAdapter());

  categoryBox = await Hive.openBox<Category>('categories');
  versesBox = await Hive.openBox<Verse>('verses');
  ruqyahsBox = await Hive.openBox<Article>('articles');
  hijamasBox = await Hive.openBox<Article>('hijamaArticles');
  masnunDuaBox = await Hive.openBox<MasnunDua>('masnunDuas');
  masnunDuaCategoriesBox = await Hive.openBox<Category>('masnunDuaCategories');
  nirapottarDuaBox = await Hive.openBox<Article>('nirapottarDuas');
  audioBox = await Hive.openBox<AudioCategory>('audios');

  Get.put(StorageController());
  Get.put(NetworkController());
  Get.put(KeeperController());
  Get.put(DataController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    final KeeperController controller = Get.find<KeeperController>();

    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'Ruqyah & Ayaat',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: controller.currentTheme.value,
        initialRoute: initialScreen,
        getPages: routePages,
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        initialBinding: MyBindings(),
      ),
    );
  }
}
