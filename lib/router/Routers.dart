import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/pages/article_view_screen.dart';
import 'package:rukiyah_and_ayat/pages/ayat/ayat_categories.dart';
import 'package:rukiyah_and_ayat/pages/ayat/ayat_list_by_category.dart';
import 'package:rukiyah_and_ayat/pages/ayat/category_section.dart';
import 'package:rukiyah_and_ayat/pages/hijama/hijama_titles.dart';
import 'package:rukiyah_and_ayat/pages/home_page.dart';
import 'package:rukiyah_and_ayat/pages/initial_screen.dart';
import 'package:rukiyah_and_ayat/pages/masnun-dua/masnun-duas.dart';
import 'package:rukiyah_and_ayat/pages/masnun-dua/masnun_dua_categories.dart';
import 'package:rukiyah_and_ayat/pages/nirapottar-dua/nirapottar_dua_titles.dart';
import 'package:rukiyah_and_ayat/pages/ruqyah/ruqyah_titles.dart';
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
        name: ayatList,
        page: () {
          Category category = Get.arguments as Category;
          return AyatListByCategory(
            category: category,
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
      page: () => const RuqyahTitles(),
    ),
    GetPage(
      name: fullArticle,
      page: () {
        Article article = Get.arguments as Article;
        return ArticleViewScreen(article: article);
      },
    ),
    GetPage(
      name: hijama,
      page: () => const HijamaArticleTitles(),
    ),
    GetPage(
      name: securityDua,
      page: () => const NirapottarDuaTitles(),
    ),
    // GetPage(
    //   name: masnunDuas,
    //   page: () {
    //     Category category = Get.arguments as Category;
    //     return MasnunDuasByCategory(category: category);
    //   },
    // ),
    // GetPage(
    //   name: masnunDuaCategories,
    //   page: () =>  const MasnunDuaCategories(),
    // ),
    GetPage(
      name: masnunDuaCategories,
      page: () =>  const UnderDevelopment(title: "মাসনুন দুআ"),
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
