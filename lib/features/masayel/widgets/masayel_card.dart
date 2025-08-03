import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/masnun-dua/masnun_dua.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';

class MasayelCard extends StatelessWidget {
  final List<MasnunDua> masayels;
  final String title;
  final String categoryTitle;
  final int index;
  const MasayelCard({super.key, required this.masayels, required this.title, required this.index, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>  Get.toNamed(
        masnunDuas,
        arguments: {
          "masnunDuas": masayels,
          "title": categoryTitle,
          "index": index,
        },
      ),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: rounded15,
        ),
        child: Text(title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineLarge,),
      ),
    );
  }
}
