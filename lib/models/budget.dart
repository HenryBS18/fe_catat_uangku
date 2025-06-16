class BudgetModel {
  final String? id;
  final String name;
  final int amount;
  final List<String> categories;
  final List<String> walletIds;
  final String period;
  final DateTime startDate;
  final int? usedAmount;
  final int? remainingAmount;
  final int? percentUsed;

  BudgetModel({
    this.id,
    required this.name,
    required this.amount,
    required this.categories,
    required this.walletIds,
    required this.period,
    required this.startDate,
    this.usedAmount,
    this.remainingAmount,
    this.percentUsed,
  });
}
