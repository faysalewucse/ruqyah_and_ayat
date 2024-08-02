import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/controllers/keeper_controller.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String confirmationMessage;
  final String cancelText;
  final String okText;
  final VoidCallback onOkPressed;

  ConfirmationDialog({super.key, required this.title, required this.confirmationMessage, required this.cancelText, required this.okText, required this.onOkPressed});

  final keeperController = Get.find<KeeperController>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.all(20.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)),
      title: Text(title),
      content: Text(
        confirmationMessage,
      ),
      actions: <Widget>[
        GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                cancelText,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            )),
        GestureDetector(
          onTap: onOkPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              okText,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
        ),
      ],
    );
  }
}