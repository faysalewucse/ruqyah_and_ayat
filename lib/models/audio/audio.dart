import 'package:hive/hive.dart';

part 'audio.g.dart';

@HiveType(typeId: 5)
class Audio extends HiveObject {
  @HiveField(0)
  String id; // Field for the MongoDB _id

  @HiveField(1)
  String title;

  @HiveField(2)
  String audioUrl;

  @HiveField(3)
  String description;

  @HiveField(4)
  int index; // New index field

  Audio({
    required this.id,
    required this.title,
    required this.audioUrl,
    required this.description,
    required this.index, // Make index required
  });

  // Convert from JSON
  factory Audio.fromJson(Map<String, dynamic> json) {
    return Audio(
      id: json['_id'] ?? '',
      title: json['title'],
      audioUrl: json['audioUrl'],
      description: json['description'],
      index: json['index'] ?? 0, // Default index to 0 if not provided
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'audioUrl': audioUrl,
      'description': description,
      'index': index, // Add index to JSON
    };
  }
}