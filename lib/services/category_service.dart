import 'package:dio/dio.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/api/config.dart';

class CategoryService{
  static Future<Response> getAllCategories () async {
    return await Api().dio.get(ApiUrls.getAllCategory);
  }

  static Future<Response> getAllCategoriesByCategoryIndex ({required int categoryIndex}) async {
    return await Api().dio.get("${ApiUrls.getAllCategory}/$categoryIndex");
  }

  static Future<Response> getVersesByCategory ({required int categoryId}) async {
    return await Api().dio.get(ApiUrls.getVersesByCategory, queryParameters: {"categoryId": categoryId});
  }
}