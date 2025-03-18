import 'dart:convert';

class LeaderBoardEntry {
  final String id;
  final String userId;
  final String fullName;
  final String country;
  final double sikkaXPoints;
  final double sikkaXCoin;
  final int rank;
  final DateTime createdAt;
  final DateTime updatedAt;

  LeaderBoardEntry({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.country,
    required this.sikkaXPoints,
    required this.sikkaXCoin,
    required this.rank,
    required this.createdAt,
    required this.updatedAt,
  });

  /// **Factory method to create an object from JSON**
  factory LeaderBoardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderBoardEntry(
      id: json['id'],
      userId: json['userId'],
      fullName: json['fullName'],
      country: json['country'],
      sikkaXPoints: double.parse(json['sikkaXPoints']),
      sikkaXCoin: double.parse(json['sikkaXCoin']),
      rank: json['rank'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  /// **Convert object to JSON**
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'fullName': fullName,
      'country': country,
      'sikkaXPoints': sikkaXPoints.toString(),
      'sikkaXCoin': sikkaXCoin.toString(),
      'rank': rank,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// **Convert List of JSON to List of LeaderBoardEntry objects**
  static List<LeaderBoardEntry> listFromJson(String jsonStr) {
    final List<dynamic> decodedList = json.decode(jsonStr);
    return decodedList.map((item) => LeaderBoardEntry.fromJson(item)).toList();
  }
}


class LeaderBoardEntryList {
  final List<LeaderBoardEntry>? posts;

  LeaderBoardEntryList({
    this.posts,
  });

  factory LeaderBoardEntryList.fromJson(List<dynamic> json) {
    List<LeaderBoardEntry> posts = <LeaderBoardEntry>[];
    posts = json.map((post) => LeaderBoardEntry.fromJson(post)).toList();

    return LeaderBoardEntryList(
      posts: posts,
    );
  }
}