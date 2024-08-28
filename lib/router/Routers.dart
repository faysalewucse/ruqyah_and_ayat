import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/pages/ayat/ayat_categories.dart';
import 'package:rukiyah_and_ayat/pages/ayat/ayat_list_by_category.dart';
import 'package:rukiyah_and_ayat/pages/ayat/category_section.dart';
import 'package:rukiyah_and_ayat/pages/home_page.dart';
import 'package:rukiyah_and_ayat/pages/initial_screen.dart';
import 'package:rukiyah_and_ayat/pages/under_development.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';

final List<GetPage<dynamic>> routePages = [
  GetPage(name: initialScreen, page: () => const InitialScreen(), children: [
    GetPage(
      name: homeScreen,
      page: () => const HomePage(),
    ),
    GetPage(
      name: categorySection,
      page: () => const CategorySection(),
    ),
    GetPage(
        name: categories,
        page: () {
          int categoryIndex = Get.arguments as int;
          return AyatCategories(
            categoryIndex: categoryIndex,
          );
        }),
    GetPage(
      name: verses,
      page: () {
        Category category = Get.arguments as Category;
        return AyatListByCategory(category: category);
      },
    ),
    GetPage(
      name: audio,
      page: () => const UnderDevelopment(title: "অডিও"),
    ),
    GetPage(
      name: ruqyah,
      page: () => const UnderDevelopment(title: "রুকইয়াহ"),
    ),
    GetPage(
      name: hijama,
      page: () => const UnderDevelopment(title: "হিজামা"),
    ),
    GetPage(
      name: securityDua,
      page: () => const UnderDevelopment(title: "নিরাপত্তার দুআ"),
    ),
    GetPage(
      name: masnunDua,
      page: () => const UnderDevelopment(title: "মাসনুন দুআ"),
    ),
    GetPage(
      name: masayel,
      page: () => const UnderDevelopment(title: "মাসায়েল"),
    ),
    GetPage(
      name: bibidh,
      page: () => const UnderDevelopment(title: "বিবিধ"),
    ),
  ])
];
