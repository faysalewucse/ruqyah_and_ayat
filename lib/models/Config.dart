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

  @HiveField(3)
  final String ayatDataVersion;

  @HiveField(4)
  final String categoryDataVersion;

  @HiveField(5)
  final String ruqyahDataVersion;

  @HiveField(6)
  final String hijamaDataVersion;

  @HiveField(7)
  final String nirapottarDataVersion;

  @HiveField(8)
  final String masnunDuaDataVersion;

  @HiveField(9)
  final String masnunDuaCategoryDataVersion; // Added missing field

  @HiveField(10)
  final String audioDataVersion;

  @HiveField(11)
  final String masayelDataVersion;

  @HiveField(12)
  final String bibidhDataVersion;

  Config({
    required this.appVersion,
    required this.releaseNotes,
    required this.dataVersion,
    required this.ayatDataVersion,
    required this.categoryDataVersion,
    required this.ruqyahDataVersion,
    required this.hijamaDataVersion,
    required this.nirapottarDataVersion,
    required this.masnunDuaDataVersion,
    required this.masnunDuaCategoryDataVersion, // Updated constructor
    required this.audioDataVersion,
    required this.masayelDataVersion,
    required this.bibidhDataVersion,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'appVersion': appVersion,
      'releaseNotes': releaseNotes,
      'dataVersion': dataVersion,
      'ayatDataVersion': ayatDataVersion,
      'categoryDataVersion': categoryDataVersion,
      'ruqyahDataVersion': ruqyahDataVersion,
      'hijamaDataVersion': hijamaDataVersion,
      'nirapottarDataVersion': nirapottarDataVersion,
      'masnunDuaDataVersion': masnunDuaDataVersion,
      'masnunDuaCategoryDataVersion': masnunDuaCategoryDataVersion, // JSON mapping
      'audioDataVersion': audioDataVersion,
      'masayelDataVersion': masayelDataVersion,
      'bibidhDataVersion': bibidhDataVersion,
    };
  }

  // Create from JSON
  factory Config.fromJson(Map<String, dynamic> json) {
    return Config(
      appVersion: json['appVersion'] as String,
      releaseNotes: json['releaseNotes'] as String,
      dataVersion: json['dataVersion'] as String,
      ayatDataVersion: json['ayatDataVersion'] as String,
      categoryDataVersion: json['categoryDataVersion'] as String,
      ruqyahDataVersion: json['ruqyahDataVersion'] as String,
      hijamaDataVersion: json['hijamaDataVersion'] as String,
      nirapottarDataVersion: json['nirapottarDataVersion'] as String,
      masnunDuaDataVersion: json['masnunDuaDataVersion'] as String,
      masnunDuaCategoryDataVersion: json['masnunDuaCategoryDataVersion'] as String, // Updated factory
      audioDataVersion: json['audioDataVersion'] as String,
      masayelDataVersion: json['masayelDataVersion'] as String,
      bibidhDataVersion: json['bibidhDataVersion'] as String,
    );
  }
}
