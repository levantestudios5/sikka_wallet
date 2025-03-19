import 'dart:convert';

class WalletConversion {
  final String? type;
  final double? amount;
  final String? status;
  final String? description;
  final String? walletId;
  final String? cryptoType;
  final String? gameId;
  final String? referralId;
  final String? id;
  final DateTime? createdAt;

  WalletConversion({
     this.type,
     this.amount,
     this.status,
     this.description,
     this.walletId,
    this.cryptoType,
    this.gameId,
    this.referralId,
     this.id,
     this.createdAt,
  });

  /// **Factory method for JSON deserialization**
  factory WalletConversion.fromJson(Map<String, dynamic> json) {
    return WalletConversion(
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      status: json['status'],
      description: json['description'],
      walletId: json['walletId'],
      cryptoType: json['cryptoType'],
      gameId: json['gameId'],
      referralId: json['referralId'],
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  /// **Method for JSON serialization**
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'status': status,
      'description': description,
      'walletId': walletId,
      'cryptoType': cryptoType,
      'gameId': gameId,
      'referralId': referralId,
      'id': id,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  /// **Helper method to convert JSON string to object**
  static WalletConversion fromJsonString(String jsonString) {
    return WalletConversion.fromJson(json.decode(jsonString));
  }

  /// **Helper method to convert object to JSON string**
  String toJsonString() {
    return json.encode(toJson());
  }
}
