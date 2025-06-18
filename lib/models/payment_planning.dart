class PaymentPlanning {
  final String? id;
  final String? walletId;
  final String title;
  final String description;
  final String? type;
  final String category;
  final int amount;
  final DateTime paymentDate;
  final String frequency;

  PaymentPlanning({
    this.id,
    this.walletId,
    required this.title,
    required this.description,
    this.type,
    required this.category,
    required this.amount,
    required this.paymentDate,
    required this.frequency,
  });
}
