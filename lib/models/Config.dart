import 'package:hive/hive.dart';

part 'Config.g.dart'; // For code generation

@HiveType(typeId: 3) // Unique ID for the Config type
class Config extends HiveObject {
  @HiveField(0)
  final String appVersion;

  @HiveField(1)
  final String releaseNotes;

  @HiveField(2)
  final String dataVersion;

  Config({
    required this.appVersion,
    required this.releaseNotes,
    required this.dataVersion,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'appVersion': appVersion,
      'releaseNotes': releaseNotes,
      'dataVersion': dataVersion,
    };
  }

  // Create from JSON
  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      appVersion: json['appVersion'] as String,
      releaseNotes: json['releaseNotes'] as String,
      dataVersion: json['dataVersion'] as String,
    );
  }
}
