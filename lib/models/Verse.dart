class Verse {
  final String title;
  final String verse;
  final String category;

  Verse({
    required this.title,
    required this.verse,
    required this.category,
  });

  // Convert a Ayat instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'verse': verse,
      'category': category,
    };
  }

  // Create an Ayat instance from a JSON object
  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      title: json['title'],
      verse: json['verse'],
      category: json['category'],
    );
  }
}
