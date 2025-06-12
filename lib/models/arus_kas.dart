class ArusKas {
  final double income;
  final double expense;
  final double netCashflow;

  ArusKas(
      {required this.income, required this.expense, required this.netCashflow});

  factory ArusKas.fromJson(Map<String, dynamic> json) {
    return ArusKas(
      income: (json['income'] as num).toDouble(),
      expense: (json['expense'] as num).toDouble(),
      netCashflow: (json['netCashflow'] as num).toDouble(),
    );
  }
}
