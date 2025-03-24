import 'dart:convert';

class Game {
  final String id;
  final String name;
  final String description;
  final String playstoreUrl;
  final String gameIconUrl;
  final bool isActive;
  final double pointsMultiplier;
  final DateTime createdAt;
  final DateTime updatedAt;

  Game({
    required this.id,
    required this.name,
    required this.description,
    required this.playstoreUrl,
    required this.gameIconUrl,
    required this.isActive,
    required this.pointsMultiplier,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Convert JSON Map to `Game` object
  factory Game.fromMap(Map<String, dynamic> map) {
    return Game(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      playstoreUrl: map['playstoreUrl'] ?? '',
      gameIconUrl: map['gameIconUrl'] ?? '',
      isActive: map['isActive'] ?? false,
      pointsMultiplier:
          double.tryParse(map['pointsMultiplier'].toString()) ?? 1.0,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  /// Convert `Game` object to JSON Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'playstoreUrl': playstoreUrl,
      'gameIconUrl': gameIconUrl,
      'isActive': isActive,
      'pointsMultiplier': pointsMultiplier.toString(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  /// Convert JSON string to `List<Game>` object
  static List<Game> fromJsonList(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((map) => Game.fromMap(map)).toList();
  }

  /// Convert `List<Game>` object to JSON string
  static String toJsonList(List<Game> games) {
    final List<Map<String, dynamic>> jsonList =
        games.map((game) => game.toMap()).toList();
    return json.encode(jsonList);
  }
}

class GameList {
  final List<Game>? posts;

  GameList({
    this.posts,
  });

  factory GameList.fromJson(List<dynamic> json) {
    List<Game> posts = <Game>[];
    posts = json.map((post) => Game.fromMap(post)).toList();
    return GameList(
      posts: posts,
    );
  }
}
