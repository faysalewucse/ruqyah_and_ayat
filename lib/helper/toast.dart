import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void showToast({required String message, bool success = false}) {
  toastification.show(
    title: Text(success ? "Success" : "Error"),
    description: Text(message),
    alignment: Alignment.bottomCenter,
    showProgressBar: false,
    style: ToastificationStyle.fillColored,
    type: success ? ToastificationType.success : ToastificationType.error,
    autoCloseDuration: const Duration(seconds: 5),
  );
}

void showSuccessToast({required String message}) {
  showToast(message: message, success: true);
}

void showErrorToast({required String message}) {
  showToast(message: message, success: false);
}