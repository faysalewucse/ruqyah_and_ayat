import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';

class ArticleTitleCard extends StatelessWidget {
  final Article article;
  final int index;

  const ArticleTitleCard({super.key, required this.article, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(fullArticle, arguments: article);
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            // border: Border(left: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.5), width: 6)),
            borderRadius: rounded20),
        child: Row(
          children: [
            Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  color: Get.isDarkMode ? Theme.of(context).scaffoldBackgroundColor : Theme.of(context).primaryColor.withOpacity(0.06),
                ),
                child: Center(child: Text("${index+1}", style: GoogleFonts.poppins(),))),
            8.kW,
            Expanded(
              child: Text(
                article.title,
                // textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
