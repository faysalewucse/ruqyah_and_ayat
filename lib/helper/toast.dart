import 'package:flutter/material.dart';

import 'package:rukiyah_and_ayat/utils/constants/app_colors.dart';
import 'package:toastification/toastification.dart';

void showToast({required String message, bool success = false, AlignmentGeometry alignment = Alignment.bottomCenter}) {
  toastification.show(
    title: Text(success ? "Success" : "Error", style: TextStyle(color: success ? AppColors.white : AppColors.black),),
    description: Text(message),
    foregroundColor: success ? AppColors.white : AppColors.black,
    alignment:alignment,
    showProgressBar: false,
    style: ToastificationStyle.fillColored,
    type: success ? ToastificationType.success : ToastificationType.error,
    primaryColor: success ? AppColors.primaryColor : AppColors.white,
    autoCloseDuration: const Duration(seconds: 5),
  );
}

void showSuccessToast({required String message, AlignmentGeometry alignment = Alignment.bottomCenter}) {
  showToast(message: message, success: true, alignment: alignment);
}

void showErrorToast({required String message, AlignmentGeometry alignment = Alignment.bottomCenter}) {
  showToast(message: message, success: false, alignment: alignment);
}