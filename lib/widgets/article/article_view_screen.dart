import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:rukiyah_and_ayat/models/Article.dart';
import 'package:rukiyah_and_ayat/utils/sizedbox_extension.dart';

class ArticleViewScreen extends StatefulWidget {
  final Article article;

  const ArticleViewScreen({super.key, required this.article});

  @override
  State<ArticleViewScreen> createState() => _ArticleViewScreenState();
}

class _ArticleViewScreenState extends State<ArticleViewScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose(); // Dispose of the controller to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // // Check if the publishedDate is valid and parse it
    // DateTime publishDate;
    // try {
    //   publishDate = DateTime.parse(article.createdAt.toString()).toLocal();
    // } catch (e) {
    //   publishDate =
    //       DateTime.now(); // Fallback to the current date if parsing fails
    // }
    //
    // // Format the publish date
    // final formattedDate = DateFormat('dd MMMM, yyyy').format(publishDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.article.title),
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        // padding: const EdgeInsets.all(10.0), // Add padding here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: RawScrollbar(
                controller: _scrollController,
                interactive: true,
                thumbColor: Theme.of(context).primaryColor.withOpacity(0.5),
                thickness: 10,
                radius: const Radius.circular(5),
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: HtmlWidget(
                      widget.article.content,
                      textStyle: const TextStyle(fontSize: 18,),
                    ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       12.kH,
            //       Text(
            //         article.author,
            //         style: Theme.of(context).textTheme.titleSmall,
            //       ),
            //       4.kH,
            //       Text(
            //         formattedDate,
            //         style: Theme.of(context).textTheme.titleSmall,
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
