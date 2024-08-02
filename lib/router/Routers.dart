import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/pages/home_page.dart';
import 'package:rukiyah_and_ayat/pages/initial_screen.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';

final List<GetPage<dynamic>> RoutePages = [
  GetPage(name: initialScreen, page: () => const InitialScreen(), children: [
    GetPage(
      name: homeScreen,
      page: () => const HomePage(),
    ),
  ])
];
