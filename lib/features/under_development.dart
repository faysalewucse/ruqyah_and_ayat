import 'package:flutter/material.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';

class UnderDevelopment extends StatelessWidget {
  final String title;
  const UnderDevelopment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings, size: 100, color: Theme.of(context).primaryColor,),
              verticalGap12,
              Text("$title সেকশনের কাজ চলমান", style: Theme.of(context).textTheme.displayLarge,),
              Text("খুব শীঘ্রই উম্নুক্ত করা হবে", style: Theme.of(context).textTheme.displayLarge,)
            ],
          ),
        ),
      ),
    );
  }
}
