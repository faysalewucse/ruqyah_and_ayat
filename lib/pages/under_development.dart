import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

class UnderDevelopment extends StatelessWidget {
  final String title;
  const UnderDevelopment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 100, color: PRIMARY_COLOR,),
            verticalGap12,
            Text("$title সেকশনের কাজ চলমান", style: Theme.of(context).textTheme.displayLarge,),
            Text("খুব শীঘ্রই উম্নুক্ত করা হবে", style: Theme.of(context).textTheme.displayLarge,)
          ],
        ),
      ),
    );
  }
}
