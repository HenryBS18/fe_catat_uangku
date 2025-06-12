class BudgetModel {
  final String id;
  final String name;
  final double amount;
  final double usedAmount;
  final double remainingAmount;
  final double percentUsed;

  BudgetModel({
    required this.id,
    required this.name,
    required this.amount,
    required this.usedAmount,
    required this.remainingAmount,
    required this.percentUsed,
  });

  factory BudgetModel.fromJson(Map<String, dynamic> json) {
    return BudgetModel(
      id: json['_id'],
      name: json['name'] ?? '-',
      amount: (json['amount'] as num).toDouble(),
      usedAmount: (json['usedAmount'] as num).toDouble(),
      remainingAmount: (json['remainingAmount'] as num).toDouble(),
      percentUsed: (json['percentUsed'] as num).toDouble(),
    );
  }
}
