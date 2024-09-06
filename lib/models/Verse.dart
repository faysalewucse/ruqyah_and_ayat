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

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final DateTime updatedAt;

  Verse({
    required this.title,
    required this.verse,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert a Verse instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'verse': verse,
      'category': category,
      'createdAt': createdAt.toIso8601String(), // Convert DateTime to ISO 8601 string
      'updatedAt': updatedAt.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }

  // Create a Verse instance from a JSON object
  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      title: json['title'],
      verse: json['verse'],
      category: json['category'],
      createdAt: DateTime.parse(json['createdAt']), // Assuming ISO 8601 string format
      updatedAt: DateTime.parse(json['updatedAt']), // Assuming ISO 8601 string format
    );
  }
}
