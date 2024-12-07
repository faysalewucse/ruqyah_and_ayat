import 'package:hive/hive.dart';

part 'Article.g.dart'; // Necessary for code generation

@HiveType(typeId: 2)
class Article extends HiveObject {
  @HiveField(0)
  String id;  // This will store the MongoDB _id as a String

  @HiveField(1)
  String title;

  @HiveField(2)
  String content;

  @HiveField(3)
  String author;

  @HiveField(4)
  List<String> tags;

  @HiveField(5)
  int index;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.tags,
    required this.index,
  });

  // Factory constructor to create an Article instance from JSON
  factory Article.fromJson(Map<String, dynamic> json) => Article(
    id: json['_id'],  // Map MongoDB _id to id
    title: json['title'],
    content: json['content'],
    author: json['author'],
    tags: List<String>.from(json['tags']),
    index: json['index'],
  );

  // Method to convert an Article instance to JSON
  Map<String, dynamic> toJson() => {
    '_id': id,  // Convert id back to MongoDB _id
    'title': title,
    'content': content,
    'author': author,
    'tags': tags,
    'index': index,
  };
}
