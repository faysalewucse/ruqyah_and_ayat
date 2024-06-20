import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Category.dart';

class ScreenCard extends StatelessWidget {
  final Screen screen;

  const ScreenCard({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => screen.page(),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            color: WHITE,
            border: Border.all(color: BORDER_COLOR_1),
            borderRadius: rounded8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(screen.iconData, size: 40, color: PRIMARY_COLOR),
            const SizedBox(height: 10),
            Text(
              screen.name,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.headlineSmall?.color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
