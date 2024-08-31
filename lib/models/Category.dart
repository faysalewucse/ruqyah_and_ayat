import 'package:hive/hive.dart';

part 'Category.g.dart'; // This is for code generation

@HiveType(typeId: 0) // Unique ID for the Category type
class Category extends HiveObject {
  @HiveField(0)
  String id; // Mapped from _id in JSON

  @HiveField(1)
  String value;

  @HiveField(2)
  String label;

  @HiveField(3)
  int categoryIndex;

  @HiveField(4)
  int index;

  Category({
    required this.id,
    required this.value,
    required this.label,
    required this.categoryIndex,
    required this.index,
  });

  // Factory method to create an instance of Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String, // Mapped from _id
      value: json['value'] as String,
      label: json['label'] as String,
      categoryIndex: json['categoryIndex'] as int,
      index: json['index'] as int,
    );
  }

  // Method to convert Category instance to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'value': value,
      'label': label,
      'categoryIndex': categoryIndex,
      'index': index,
    };
  }
}
