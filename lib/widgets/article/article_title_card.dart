import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/helper/constant.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/router/routes.dart';

class ArticleTitleCard extends StatelessWidget {
  final Article article;

  const ArticleTitleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(fullArticle, arguments: article);
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: WHITE,
            // border: Border(left: BorderSide(color: PRIMARY_COLOR.withOpacity(0.5), width: 6)),
            borderRadius: rounded20
        ),
        child: Text(
          article.title,
          // textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
    );
  }
}
