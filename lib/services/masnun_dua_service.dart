import 'package:dio/dio.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/api/config.dart';

class MasnunDuaService{
  static Future<Response> getMasnunDuas () async {
    return await Api().dio.get(ApiUrls.getAllMasnunDuas);
  }

  static Future<Response> getMasnunDuaCategories () async {
    return await Api().dio.get(ApiUrls.getAllMasnunDuaCategories);
  }
}