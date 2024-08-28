import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/bindings.dart';
import 'package:rukiyah_and_ayat/helper/Theme.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/pages/home_page.dart';
import 'package:rukiyah_and_ayat/router/Routers.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;

    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'Ruqyah & Ayaat',
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme,
        initialRoute: initialScreen,
        getPages: routePages,
        locale: const Locale('en','US'),
        fallbackLocale: const Locale('en','US'),
        initialBinding: MyBindings(),
      ),
    );
  }
}
