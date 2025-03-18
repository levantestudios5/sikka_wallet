import 'dart:convert';

class SikkaXNews {
  final String id;
  final String title;
  final String content;
  final String imageUrl;
  final String externalLink;
  final bool isActive;
  final bool isPinned;
  final DateTime createdAt;

  SikkaXNews({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.externalLink,
    required this.isActive,
    required this.isPinned,
    required this.createdAt,
  });

  // Factory constructor to create a model from JSON
  factory SikkaXNews.fromJson(Map<String, dynamic> json) {
    return SikkaXNews(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      externalLink: json['externalLink'],
      isActive: json['isActive'],
      isPinned: json['isPinned'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'externalLink': externalLink,
      'isActive': isActive,
      'isPinned': isPinned,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Static method to parse a list of JSON objects into a list of SikkaXNews
  static List<SikkaXNews> listFromJson(String str) {
    final List<dynamic> jsonData = json.decode(str);
    return jsonData.map((item) => SikkaXNews.fromJson(item)).toList();
  }
}



class SikkaXNewsList {
  final List<SikkaXNews>? posts;

  SikkaXNewsList({
    this.posts,
  });

  factory SikkaXNewsList.fromJson(List<dynamic> json) {
    List<SikkaXNews> posts = <SikkaXNews>[];
    posts = json.map((post) => SikkaXNews.fromJson(post)).toList();

    return SikkaXNewsList(
      posts: posts,
    );
  }
}
