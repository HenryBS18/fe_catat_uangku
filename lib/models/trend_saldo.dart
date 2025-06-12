class TrendSaldo {
  final DateTime date;
  final double balance;

  TrendSaldo({required this.date, required this.balance});

  factory TrendSaldo.fromJson(Map<String, dynamic> json) {
    return TrendSaldo(
      date: DateTime.parse(json['date'] as String),
      balance: (json['balance']).toDouble(), // ✅ convert num to double
    );
  }
}
