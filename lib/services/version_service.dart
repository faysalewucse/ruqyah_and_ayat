import 'package:dio/dio.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/api/config.dart';

class VersionService{
  static Future<Response> getAppVersion () async {
    return await Api().dio.get(ROOT_API_URL);
  }
}