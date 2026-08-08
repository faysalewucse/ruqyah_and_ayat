import 'package:dio/dio.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/api/config.dart';

class MasayelService{
  static Future<Response> getMasayels () async {
    return await Api().dio.get(ApiUrls.getAllMasayels);
  }

  static Future<Response> getMasayelCategories () async {
    return await Api().dio.get(ApiUrls.getAllMasayelCategories);
  }
}