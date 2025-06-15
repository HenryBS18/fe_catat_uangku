class TopExpenseItem {
  final String category;
  final double total;

  TopExpenseItem({required this.category, required this.total});

  factory TopExpenseItem.fromJson(Map<String, dynamic> json) {
    return TopExpenseItem(
      category: json['category'],
      total: (json['total'] as num).toDouble(),
    );
  }
}
