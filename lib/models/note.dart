class NoteModel {
  final String? id;
  final String walletId;
  final String type;
  final int amount;
  final String category;
  final String date;
  final String note;

  NoteModel({
    this.id,
    required this.walletId,
    required this.type,
    required this.amount,
    required this.category,
    required this.date,
    required this.note,
  });
factory NoteModel.fromJson(Map<String, dynamic> json) {
  return NoteModel(
    id: json['_id'],
    walletId: json['walletId'],
    type: json['type'],
    amount: json['amount'],
    category: json['category'],
    date: json['date'],
    note: json['note'],
  );
}
  // Bisa tambahkan fromJson / toJson jika kamu pakai
}
