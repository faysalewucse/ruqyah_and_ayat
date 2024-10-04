import 'package:hive/hive.dart';

part 'masnun_dua.g.dart'; // Necessary for code generation

@HiveType(typeId: 4)
class MasnunDua extends HiveObject {
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

  @HiveField(6)
  DateTime createdAt;  // Replacing publishedDate with createdAt

  @HiveField(7)
  DateTime updatedAt;  // Adding updatedAt field

  @HiveField(8)
  String category;

  MasnunDua({
    required this.id,
    required this.category,
    required this.title,
    required this.content,
    required this.author,
    required this.tags,
    required this.index,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory constructor to create an MasnunDua instance from JSON
  factory MasnunDua.fromJson(Map<String, dynamic> json) => MasnunDua(
    id: json['_id'],
    category: json['category'],
    title: json['title'],
    content: json['content'],
    author: json['author'],
    tags: List<String>.from(json['tags']),
    index: json['index'],
    createdAt: DateTime.parse(json['createdAt']),  // Parse createdAt field
    updatedAt: DateTime.parse(json['updatedAt']),  // Parse updatedAt field
  );

  // Method to convert an MasnunDua instance to JSON
  Map<String, dynamic> toJson() => {
    '_id': id,  // Convert id back to MongoDB _id
    'title': title,
    'category': category,
    'content': content,
    'author': author,
    'tags': tags,
    'index': index,
    'createdAt': createdAt.toIso8601String(),  // Convert createdAt to ISO string
    'updatedAt': updatedAt.toIso8601String(),  // Convert updatedAt to ISO string
  };
}
