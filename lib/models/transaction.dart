class Transaction {
  final String walletId;
  final String type;
  final int amount;
  final String category;
  final String date;
  final String note;

  Transaction({
    required this.walletId,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      walletId: json['walletId'] ?? '',
      type: json['type'] ?? '',
      amount: json['amount'] ?? 0,
      category: json['category'] ?? '',
      date: json['date'] ?? '',
      note: json['note'] ?? '',
    );
  }
}
