import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/buttons/primary_button.dart';
import 'package:rukiyah_and_ayat/widgets/custom_loader.dart';

class DialogHelper {
  static void showNoInternetDialog() {
    Get.dialog(
      barrierDismissible: false,
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: rounded20,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(PhosphorIcons.wifi_slash, color: PRIMARY_COLOR, size: 50,),
              20.kH,
              Text("ইন্টারনেট সংযোগ নেই", style: primary20W500),
              const Text("প্রথমবার অ্যাপ ডাটা ডাউনলোড করার জন্য আপনার ইন্টারনেট সংযোগ থাকতে হবে।", textAlign: TextAlign.center,),
              32.kH,
              PrimaryButton(
                label: "অ্যাপ বন্ধ করুন",
                onTap: () {
                  if (Platform.isIOS) {
                    exit(0);
                  } else if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: rounded20
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomLoader(),
              const SizedBox(height: 8),
              Text(message ?? 'Loading...'),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading({int? id}) {
    if (Get.isDialogOpen!) Get.back(id: id);
  }

}