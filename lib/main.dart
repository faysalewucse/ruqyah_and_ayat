import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/bindings.dart';
import 'package:rukiyah_and_ayat/helper/Theme.dart';
import 'package:rukiyah_and_ayat/pages/home_page.dart';
import 'package:rukiyah_and_ayat/router/Routers.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ruqyah & Ayaat',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      initialRoute: initialScreen,
      getPages: RoutePages,
      locale: const Locale('en','US'),
      fallbackLocale: const Locale('en','US'),
      initialBinding: MyBindings(),
    );
  }
}
