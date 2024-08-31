import 'package:dio/dio.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/api/config.dart';

class CategoryService{
  static Future<Response> getAllCategories () async {
    return await Api().dio.get(GET_ALL_CATEGORY);
  }

  static Future<Response> getAllCategoriesByCategoryIndex ({required int categoryIndex}) async {
    return await Api().dio.get("$GET_ALL_CATEGORY/$categoryIndex");
  }

  static Future<Response> getVersesByCategory ({required int categoryId}) async {
    return await Api().dio.get(GET_VERSES_BY_CATEGORY, queryParameters: {"categoryId": categoryId});
  }
}