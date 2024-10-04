import 'package:hive/hive.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';
import 'package:rukiyah_and_ayat/models/Verse.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';

late Box<Category> categoryBox;
late Box<Verse> versesBox;
late Box<Article> ruqyahsBox;
late Box<Article> hijamasBox;
late Box<MasnunDua> masnunDuaBox;
late Box<Category> masnunDuaCategoriesBox;
late Box<Article> nirapottarDuaBox;