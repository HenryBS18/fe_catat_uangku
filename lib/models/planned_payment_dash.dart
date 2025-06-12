class PlannedPayment {
  final String id;
  final String title;
  final String description;
  final String wallet;
  final String category;
  final double amount;
  final String type;
  final String status;
  final DateTime paymentDate;
  final int daysRemaining;

  PlannedPayment({
    required this.id,
    required this.title,
    required this.description,
    required this.wallet,
    required this.category,
    required this.amount,
    required this.type,
    required this.status,
    required this.paymentDate,
    required this.daysRemaining,
  });

  factory PlannedPayment.fromJson(Map<String, dynamic> json) {
    return PlannedPayment(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      wallet: json['wallet'],
      category: json['category'],
      amount: (json['amount'] as num).toDouble(),
      type: json['type'],
      status: json['status'],
      paymentDate: DateTime.parse(json['payment_date']),
      daysRemaining:
          int.tryParse(json['hours_remaining']?.toString() ?? '0') ?? 0,
    );
  }
}
