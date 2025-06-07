import 'package:flutter_test/flutter_test.dart';
import 'package:fe_catat_uangku/models/note.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_note_service.dart';

void main() {
  late MockNoteService noteService;

  setUp(() async {
    // Menyiapkan mock shared preferences dan service sebelum tiap test
    SharedPreferences.setMockInitialValues({});
    noteService = MockNoteService();
  });

  group('Mock Test - NoteService', () {
    test('Create transaction should return true', () async {
      // Tujuan: Menguji apakah transaksi berhasil dibuat
      final transaction = NoteModel(
        walletId: 'mockWalletId',
        type: 'expense',
        amount: 15000,
        category: 'makanan',
        date: '2025-06-05T12:00:00Z',
        note: 'ayam penyet',
      );

      final result = await noteService.createNote(transaction);

      // Hasil yang diharapkan: true
      expect(result, isTrue);
    });

    test('Get transaction by wallet should return non-empty list', () async {
      // Tujuan: Memastikan transaksi dapat diambil berdasarkan walletId
      final walletId = 'mockWalletId';
      await noteService.createNote(NoteModel(
        walletId: walletId,
        type: 'income',
        amount: 100000,
        category: 'gaji',
        date: '2025-06-01T00:00:00Z',
        note: 'Gaji bulanan',
      ));

      final result = await noteService.getNotesByWallet(walletId);

      // Hasil yang diharapkan: list tidak kosong dan sesuai kategori
      expect(result, isA<List<NoteModel>>());
      expect(result.length, greaterThan(0));
      expect(result.first.category, equals('gaji'));
    });

    test('Update transaction should return true', () async {
      // Tujuan: Menguji apakah transaksi dapat diperbarui
      final transaction = NoteModel(
        walletId: 'mockWalletId',
        type: 'expense',
        amount: 20000,
        category: 'makanan',
        date: '2025-06-06T12:00:00Z',
        note: 'ayam goreng',
      );

      await noteService.createNote(transaction);
      final created =
          (await noteService.getNotesByWallet('mockWalletId')).first;

      final updated = await noteService.updateNote(
        created.id!,
        NoteModel(
          walletId: created.walletId,
          type: 'expense',
          amount: 25000,
          category: 'makanan',
          date: created.date,
          note: 'ayam bakar',
        ),
      );

      // Hasil yang diharapkan: true
      expect(updated, isTrue);
    });

    test('Delete transaction should return true', () async {
      // Tujuan: Menguji apakah transaksi bisa dihapus
      final transaction = NoteModel(
        walletId: 'mockWalletId',
        type: 'expense',
        amount: 10000,
        category: 'minuman',
        date: '2025-06-07T12:00:00Z',
        note: 'es teh',
      );

      await noteService.createNote(transaction);
      final created =
          (await noteService.getNotesByWallet('mockWalletId')).first;

      final result = await noteService.deleteNote(created.id!);

      // Hasil yang diharapkan: true
      expect(result, isTrue);
    });

    test('Get transaction summary should return total amount', () async {
      // Tujuan: Menguji ringkasan transaksi berdasarkan filter
      await noteService.createNote(NoteModel(
        walletId: 'mockWalletId',
        type: 'expense',
        amount: 5000,
        category: 'jajan',
        date: '2025-06-08T12:00:00Z',
        note: 'ciki',
      ));

      final summary =
          await noteService.getNoteSummary(filters: {'type': 'expense'});

      // Hasil yang diharapkan: total > 0
      expect(summary['summary']['total'], greaterThan(0));
    });
  });
}
