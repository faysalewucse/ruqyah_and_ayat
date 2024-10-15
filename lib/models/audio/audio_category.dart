import 'package:hive/hive.dart';
import 'audio.dart'; // Import the Audio class

part 'audio_category.g.dart';

@HiveType(typeId: 6)
class AudioCategory extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  List<Audio> children;

  @HiveField(3)
  int index;

  AudioCategory({
    required this.id,
    required this.title,
    required this.children,
    required this.index,
  });

  // Convert from JSON
  factory AudioCategory.fromJson(Map<String, dynamic> json) {
    var childrenFromJson = json['children'] as List;
    List<Audio> audioList = childrenFromJson.map((i) => Audio.fromJson(i)).toList();

    return AudioCategory(
      id: json['_id'] ?? '',
      title: json['title'],
      children: audioList,
      index: json['index'] ?? 0,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'children': children.map((audio) => audio.toJson()).toList(),
      'index': index,
    };
  }
}