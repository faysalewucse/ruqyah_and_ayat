import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/features/masayel/masayel_categories.dart';
import 'package:rukiyah_and_ayat/features/masayel/masayels_by_category.dart';
import 'package:rukiyah_and_ayat/features/masnun-dua/category_duas.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/audio/audio.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';
import 'package:rukiyah_and_ayat/widgets/article/article_view_screen.dart';
import 'package:rukiyah_and_ayat/features/audio/audio_player.dart';
import 'package:rukiyah_and_ayat/features/audio/audio_categories.dart';
import 'package:rukiyah_and_ayat/features/ayat/ayat_categories.dart';
import 'package:rukiyah_and_ayat/features/ayat/ayat_list_by_category.dart';
import 'package:rukiyah_and_ayat/features/ayat/category_section.dart';
import 'package:rukiyah_and_ayat/features/hijama/hijama_titles.dart';
import 'package:rukiyah_and_ayat/features/home_page.dart';
import 'package:rukiyah_and_ayat/features/initial_screen.dart';
import 'package:rukiyah_and_ayat/features/masnun-dua/masnun-duas.dart';
import 'package:rukiyah_and_ayat/features/masnun-dua/masnun_dua_categories.dart';
import 'package:rukiyah_and_ayat/features/nirapottar-dua/nirapottar_dua_titles.dart';
import 'package:rukiyah_and_ayat/features/ruqyah/ruqyah_titles.dart';
import 'package:rukiyah_and_ayat/features/under_development.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';

final List<GetPage<dynamic>> routePages = [
  GetPage(
    name: initialScreen,
    page: () => const InitialScreen(),
    children: [
      GetPage(name: homeScreen, page: () => const HomePage()),
      GetPage(name: categorySection, page: () => const CategorySection()),
      GetPage(
        name: categories,
        page: () {
          int categoryIndex = Get.arguments as int;
          return AyatCategories(categoryIndex: categoryIndex);
        },
      ),
      GetPage(
        name: ayatList,
        page: () {
          Category category = Get.arguments as Category;
          return AyatListByCategory(category: category);
        },
      ),
      GetPage(
        name: verses,
        page: () {
          Category category = Get.arguments as Category;
          return AyatListByCategory(category: category);
        },
      ),
      GetPage(name: audioCategories, page: () => const AudioCategories()),
      GetPage(
        name: playAudio,
        page: () {
          Audio audio = Get.arguments as Audio;
          return RuqyahPlayer(audio: audio);
        },
      ),
      GetPage(name: ruqyah, page: () => const RuqyahTitles()),
      GetPage(
        name: fullArticle,
        page: () {
          Article article = Get.arguments as Article;
          return ArticleViewScreen(article: article);
        },
      ),
      GetPage(name: hijama, page: () => const HijamaArticleTitles()),
      GetPage(name: securityDua, page: () => const NirapottarDuaTitles()),
      GetPage(
        name: masnunDuas,
        page: () {
          final arguments = Get.arguments as Map<String, dynamic>;
          return MasnunDuasByCategory(masnunDuas: arguments["masnunDuas"] ?? [], title: arguments["title"] ?? "মাসনুন দুআ");
        },
      ),
      GetPage(
        name: categoryDuas,
        page: () {
          Category category = Get.arguments as Category;
          return CategoryDuas(category: category);
        },
      ),
      GetPage(
        name: masnunDuaCategories,
        page: () =>  const MasnunDuaCategories(),
      ),
      GetPage(name: masayel, page: () => const MasayelCategories()),
      GetPage(
        name: masayelsByCategory,
        page: () {
          Category category = Get.arguments as Category;
          return MasayelsByCategory(category: category);
        },
      ),
      GetPage(name: bibidh, page: () => const UnderDevelopment(title: "বিবিধ")),
    ],
  ),
];
