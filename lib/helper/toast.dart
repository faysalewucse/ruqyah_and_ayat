import 'package:flutter/material.dart';

import 'package:rukiyah_and_ayat/utils/constants/app_colors.dart';
import 'package:toastification/toastification.dart';

void showToast({required String message, bool success = false}) {
  toastification.show(
    title: Text(success ? "Success" : "Error", style: TextStyle(color: success ? AppColors.white : AppColors.black),),
    description: Text(message),
    foregroundColor: success ? AppColors.white : AppColors.black,
    alignment: Alignment.bottomCenter,
    showProgressBar: false,
    style: ToastificationStyle.fillColored,
    type: success ? ToastificationType.success : ToastificationType.error,
    primaryColor: success ? AppColors.primaryColor : AppColors.white,
    autoCloseDuration: const Duration(seconds: 5),
  );
}

void showSuccessToast({required String message}) {
  showToast(message: message, success: true);
}

void showErrorToast({required String message}) {
  showToast(message: message, success: false);
}