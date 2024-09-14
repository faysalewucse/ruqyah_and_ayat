import 'package:hive/hive.dart';

part 'Category.g.dart'; // This is for code generation

@HiveType(typeId: 0) // Unique ID for the Category type
class Category extends HiveObject {
  @HiveField(0)
  String id; // Mapped from _id in JSON

  @HiveField(2)
  String label;

  @HiveField(3)
  int categoryIndex;

  @HiveField(4)
  int index;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  Category({
    required this.id,
    required this.label,
    required this.categoryIndex,
    required this.index,
    required this.createdAt,
    required this.updatedAt,
  });

  // Factory method to create an instance of Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String, // Mapped from _id
      label: json['label'] as String,
      categoryIndex: json['categoryIndex'] as int,
      index: json['index'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String), // Assuming ISO 8601 string format
      updatedAt: DateTime.parse(json['updatedAt'] as String), // Assuming ISO 8601 string format
    );
  }

  // Method to convert Category instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'label': label,
      'categoryIndex': categoryIndex,
      'index': index,
      'createdAt': createdAt.toIso8601String(), // Convert DateTime to ISO 8601 string
      'updatedAt': updatedAt.toIso8601String(), // Convert DateTime to ISO 8601 string
    };
  }
}
