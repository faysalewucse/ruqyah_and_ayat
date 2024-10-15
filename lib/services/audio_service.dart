import 'package:dio/dio.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/api/config.dart';

class AudioService{
  static Future<Response> getAllAudios () async {
    return await Api().dio.get(GET_ALL_AUDIOS);
  }
}