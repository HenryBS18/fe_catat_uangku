class TransactionModel {
  final String? id;
  final String walletId;
  final String type;
  final int amount;
  final String category;
  final String date;
  final String? note;

  TransactionModel({
    this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });
}
