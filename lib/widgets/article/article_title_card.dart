import 'package:bangla_converter/bangla_converter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';
import 'package:rukiyah_and_ayat/widgets/leading_index.dart';

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
           LeadingIndex(index: index + 1),
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
