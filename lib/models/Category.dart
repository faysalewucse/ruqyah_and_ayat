import 'package:hive/hive.dart';

part 'Category.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(2)
  String label;

  @HiveField(3)
  int? categoryIndex;

  @HiveField(4)
  int index;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime updatedAt;

  Category({
    required this.id,
    required this.label,
    this.categoryIndex,
    required this.index,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['_id'] as String,
      label: json['label'] as String,
      categoryIndex: json['categoryIndex'] != null ? json['categoryIndex'] as int : null,
      index: json['index'] as int,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'label': label,
      'categoryIndex': categoryIndex,
      'index': index,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}