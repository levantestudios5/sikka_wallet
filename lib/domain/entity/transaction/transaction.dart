class Transaction {
  final String? id;
  final String? type;
  final double? amount;
  final String? status;
  final String? cryptoType;
  final String? gameId;
  final String? referralId;
  final String? description;
  final String? walletId;
  final DateTime? createdAt;

  Transaction({
    this.id,
    this.type,
    this.amount,
    this.status,
    this.cryptoType,
    this.gameId,
    this.referralId,
    this.description,
    this.walletId,
    this.createdAt,
  });

  // Factory constructor for creating a Transaction from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      type: json['type'],
      amount: (json['amount'] as num).toDouble(),
      status: json['status'],
      cryptoType: json['cryptoType'],
      gameId: json['gameId'],
      referralId: json['referralId'],
      description: json['description'],
      walletId: json['walletId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  // Convert a Transaction object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'amount': amount,
      'status': status,
      'cryptoType': cryptoType,
      'gameId': gameId,
      'referralId': referralId,
      'description': description,
      'walletId': walletId,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}

// Function to parse a list of transactions
List<Transaction> parseTransactions(List<dynamic> jsonList) {
  return jsonList.map((json) => Transaction.fromJson(json)).toList();
}
