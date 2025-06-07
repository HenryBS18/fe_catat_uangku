import 'package:fe_catat_uangku/models/note.dart';

class MockNoteService {
  final List<NoteModel> _mockDatabase = [];

  Future<bool> createNote(NoteModel transaction) async {
    final mock = NoteModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      walletId: transaction.walletId,
      type: transaction.type,
      amount: transaction.amount,
      category: transaction.category,
      date: transaction.date,
      note: transaction.note,
    );
    _mockDatabase.add(mock);
    return true;
  }

  Future<bool> updateNote(String id, NoteModel transaction) async {
    final index = _mockDatabase.indexWhere((t) => t.id == id);
    if (index == -1) throw Exception("Transaksi tidak ditemukan");

    _mockDatabase[index] = NoteModel(
      id: id,
      walletId: transaction.walletId,
      type: transaction.type,
      amount: transaction.amount,
      category: transaction.category,
      date: transaction.date,
      note: transaction.note,
    );
    return true;
  }

  Future<bool> deleteNote(String id) async {
    final index = _mockDatabase.indexWhere((t) => t.id == id);
    if (index == -1) throw Exception("Transaksi tidak ditemukan");
    _mockDatabase.removeAt(index);
    return true;
  }

  Future<List<NoteModel>> getNotesByWallet(String walletId) async {
    return _mockDatabase.where((t) => t.walletId == walletId).toList();
  }

  Future<List<NoteModel>> getAllNotes({
    String? type,
    String? category,
    String? startDate,
    String? endDate,
  }) async {
    return _mockDatabase.where((t) {
      final matchType = type == null || t.type == type;
      final matchCategory = category == null || t.category == category;
      final matchDate = (startDate == null || endDate == null) ||
          (t.date.compareTo(startDate) >= 0 && t.date.compareTo(endDate) <= 0);
      return matchType && matchCategory && matchDate;
    }).toList();
  }

  Future<NoteModel> getNoteById(String id) async {
    final transaction = _mockDatabase.firstWhere((t) => t.id == id,
        orElse: () => throw Exception("Transaksi tidak ditemukan"));
    return transaction;
  }

  Future<Map<String, dynamic>> getNoteSummary(
      {Map<String, String>? filters}) async {
    final filtered = await getAllNotes(
      type: filters?["type"],
      category: filters?["category"],
      startDate: filters?["startDate"],
      endDate: filters?["endDate"],
    );

    final total = filtered.fold<int>(0, (sum, t) => sum + t.amount);
    return {
      "summary": {"total": total},
      "filters": filters ?? {}
    };
  }
}
