import 'dart:convert';

class WalletData {
  final String? id;
  final int? sikkaXPoints;
  final String? sikkaXCoin;
  final int? shibaInu;
  final int? pendingPoints;
  final String? userId;
  final String? ftxCoin;
  final String? bnbCoin;
  final String? batCoin;
  final String? polkadotCoin;
  final String? neoCoin;
  final String? dodgeCoin;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  WalletData({
     this.id,
     this.sikkaXPoints,
     this.sikkaXCoin,
     this.shibaInu,
     this.pendingPoints,
     this.userId,
     this.ftxCoin,
     this.bnbCoin,
     this.batCoin,
     this.polkadotCoin,
     this.neoCoin,
     this.dodgeCoin,
     this.createdAt,
     this.updatedAt,
  });

  /// **Factory constructor to create a WalletData object from JSON**
  factory WalletData.fromJson(Map<String, dynamic> json) {
    return WalletData(
      id: json["id"],
      sikkaXPoints: json["sikkaXPoints"],
      sikkaXCoin: json["sikkaXCoin"],
      shibaInu: json["shibaInu"],
      pendingPoints: json["pendingPoints"],
      userId: json["userId"],
      ftxCoin: json["ftxCoin"],
      bnbCoin: json["bnbCoin"],
      batCoin: json["batCoin"],
      polkadotCoin: json["polkadotCoin"],
      neoCoin: json["neoCoin"],
      dodgeCoin: json["dodgeCoin"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }

  /// **Method to convert WalletData object to JSON**
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sikkaXPoints": sikkaXPoints,
      "sikkaXCoin": sikkaXCoin,
      "shibaInu": shibaInu,
      "pendingPoints": pendingPoints,
      "userId": userId,
      "ftxCoin": ftxCoin,
      "bnbCoin": bnbCoin,
      "batCoin": batCoin,
      "polkadotCoin": polkadotCoin,
      "neoCoin": neoCoin,
      "dodgeCoin": dodgeCoin,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
  @override
  String toString() {
    return 'WalletData('
        'id: $id, '
        'sikkaXPoints: $sikkaXPoints, '
        'sikkaXCoin: $sikkaXCoin, '
        'shibaInu: $shibaInu, '
        'pendingPoints: $pendingPoints, '
        'userId: $userId, '
        'ftxCoin: $ftxCoin, '
        'bnbCoin: $bnbCoin, '
        'batCoin: $batCoin, '
        'polkadotCoin: $polkadotCoin, '
        'neoCoin: $neoCoin, '
        'dodgeCoin: $dodgeCoin, '
        'createdAt: ${createdAt?.toIso8601String()}, '
        'updatedAt: ${updatedAt?.toIso8601String()}'
        ')';
  }

  /// **Method to get a list of coins separately**
  List<Map<String, String>> getCoinList() {
    return [
      {"name": "SikkaX Game Coin", "amount": sikkaXCoin??""},
      {"name": "ShibaInu Game Coin", "amount": shibaInu.toString()??""},
      // {"name": "FTX Game Coin", "amount": ftxCoin??""},
      // {"name": "BNB Game Coin", "amount": bnbCoin??""},
      // {"name": "BAT Game Coin", "amount": batCoin??""},
      // {"name": "Polkadot Game Coin", "amount": polkadotCoin??""},
      // {"name": "NEO Game Coin", "amount": neoCoin??""},
      // {"name": "Dodge Game Coin", "amount": dodgeCoin??""},
    ];
  }
}
