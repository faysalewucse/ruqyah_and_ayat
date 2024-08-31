import 'package:dio/dio.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/api/config.dart';

class VersesService{
  static Future<Response> getVerses () async {
    return await Api().dio.get(GET_VERSES_BY_CATEGORY);
  }
}