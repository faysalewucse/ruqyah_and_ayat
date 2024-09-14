import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:rukiyah_and_ayat/helper/colors.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';

class ArticleScreen extends StatelessWidget {
  final Article article;

  const ArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    // Check if the publishedDate is valid and parse it
    DateTime publishDate;
    try {
      publishDate = DateTime.parse(article.createdAt.toString()).toLocal();
    } catch (e) {
      publishDate =
          DateTime.now(); // Fallback to the current date if parsing fails
    }

    // Format the publish date
    final formattedDate = DateFormat('dd MMMM, yyyy').format(publishDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(10.0), // Add padding here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: HtmlWidget(
                  article.content,
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  12.kH,
                  Text(
                    article.author,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  4.kH,
                  Text(
                    formattedDate,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
