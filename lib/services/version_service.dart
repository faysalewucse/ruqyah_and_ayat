import 'package:dio/dio.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/api/config.dart';

class VersionService{
  static Future<Response> getAppConfig () async {
    return await Api().dio.get(APP_CONFIG_API_URL);
  }
}