import 'dart:convert';

class WalletConversionRequest {
  final double amount;
  final String conversionType;

  WalletConversionRequest({
    required this.amount,
    required this.conversionType,
  });

  /// **Factory method for JSON deserialization**
  factory WalletConversionRequest.fromJson(Map<String, dynamic> json) {
    return WalletConversionRequest(
      amount: (json['amount'] as num).toDouble(),
      conversionType: json['conversionType'],
    );
  }

  /// **Method for JSON serialization**
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'conversionType': conversionType,
    };
  }

  /// **Helper method to convert JSON string to object**
  static WalletConversionRequest fromJsonString(String jsonString) {
    return WalletConversionRequest.fromJson(json.decode(jsonString));
  }

  /// **Helper method to convert object to JSON string**
  String toJsonString() {
    return json.encode(toJson());
  }
}
