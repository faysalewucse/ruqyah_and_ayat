import 'package:dio/dio.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/api/config.dart';

class HijamaService{
  static Future<Response> getHijamaArticles () async {
    return await Api().dio.get(ApiUrls.getAllHijamaArticles);
  }
}