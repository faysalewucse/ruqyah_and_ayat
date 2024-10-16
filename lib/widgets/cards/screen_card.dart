import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Screen.dart';

class ScreenCard extends StatelessWidget {
  final Screen screen;

  const ScreenCard({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(screen.route),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: rounded20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: Get.isDarkMode ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColor.withOpacity(0.06),
              ),
              child: Icon(
                screen.iconData,
                size: 35,
                color: Theme.of(context).textTheme.headlineSmall?.color,
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                screen.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.headlineSmall?.color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
