import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

class UnderDevelopment extends StatelessWidget {
  const UnderDevelopment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.settings, size: 100, color: PRIMARY_COLOR,),
            verticalGap12,
            Text("Under Development. Release soon", style: Theme.of(context).textTheme.displayLarge,)
          ],
        ),
      ),
    );
  }
}
