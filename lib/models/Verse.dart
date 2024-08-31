import 'package:hive/hive.dart';

part 'Verse.g.dart'; // For code generation

@HiveType(typeId: 1) // Unique ID for the Verse type
class Verse extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String verse;

  @HiveField(2)
  final String category;

  Verse({
    required this.title,
    required this.verse,
    required this.category,
  });

  // Convert a Verse instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'verse': verse,
      'category': category,
    };
  }

  // Create a Verse instance from a JSON object
  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      title: json['title'],
      verse: json['verse'],
      category: json['category'],
    );
  }
}
