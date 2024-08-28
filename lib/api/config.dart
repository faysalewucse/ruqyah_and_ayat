import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rukiyah_and_ayat/api/api_urls.dart';
import 'package:rukiyah_and_ayat/controllers/storage_controller.dart';
import 'package:rukiyah_and_ayat/helper/toast.dart';

class Api {
  Dio dio = Dio();
  final getStorage = GetStorage();

  Api() {
    dio = Dio(
      BaseOptions(
        baseUrl: ROOT_API_URL,
        headers: {
          'Content-Type': 'application/json',
        },
        receiveTimeout: const Duration(seconds: 60),
        connectTimeout: const Duration(seconds: 60),
        sendTimeout: const Duration(seconds: 60),
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = StorageController().getAuthToken();
          print("${options.method} : ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          debugPrint(
              "${error.type} dioError message====>${error.response?.data["message"]}",
              wrapWidth: 1024);
          if (error.type == DioExceptionType.connectionError) {
            showErrorToast(message: 'Server Error');
          }
          else if (error.type == DioExceptionType.connectionTimeout) {
            showErrorToast(message: 'Connection Timeout');
          } else if (error.type == DioExceptionType.receiveTimeout) {
            showErrorToast(message: 'Receive Timeout');
          } else if (error.type == DioExceptionType.badResponse) {
            if (error.response?.statusCode == 400) {
              showErrorToast(message: error.response?.data["message"]);
            } else if (error.response?.statusCode == 401) {
              showErrorToast(message: error.response?.data["message"]);
              // if (!authController.isLogin.value) {
              //   getStorage.write(AUTH_TOKEN, "");
              //   Get.toNamed(signInScreen);
              // }
            } else if (error.response?.statusCode == 403) {
              showErrorToast(message: error.response?.data["message"]);
              StorageController().removeAuthToken();
            } else {
              debugPrint(
                  "${error.response?.statusCode} dioError message====>${error.response?.data["message"]}",
                  wrapWidth: 1024);
              showErrorToast(message: "Error occurred.");
            }
          } else if (error.type == DioExceptionType.sendTimeout) {
            showErrorToast(message: 'Send Timeout');
          } else if (error.type == DioExceptionType.cancel) {
            showErrorToast(message: 'Request Cancelled');
          } else if (error.message!.contains("Failed host lookup")) {
            showErrorToast(message: "Service Not Available");
          } else {
            showErrorToast(message: error.message ?? "Unknown Error");
          }

          return handler.next(error);
        },
      ),
    );
  }
}
