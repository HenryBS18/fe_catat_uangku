import 'package:flutter_test/flutter_test.dart';
import 'package:fe_catat_uangku/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_transaction_service.dart';

void main() {
  late MockTransactionService transactionService;

  setUp(() async {
    // Menyiapkan mock shared preferences dan service sebelum tiap test
    SharedPreferences.setMockInitialValues({});
    transactionService = MockTransactionService();
  });

  group('Mock Test - TransactionService', () {
    test('Create transaction should return true', () async {
      // Tujuan: Menguji apakah transaksi berhasil dibuat
      final transaction = TransactionModel(
        walletId: 'mockWalletId',
        type: 'expense',
        amount: 15000,
        category: 'makanan',
        date: '2025-06-05T12:00:00Z',
        note: 'ayam penyet',
      );

      final result = await transactionService.createTransaction(transaction);

      // Hasil yang diharapkan: true
      expect(result, isTrue);
    });

    test('Get transaction by wallet should return non-empty list', () async {
      // Tujuan: Memastikan transaksi dapat diambil berdasarkan walletId
      final walletId = 'mockWalletId';
      await transactionService.createTransaction(TransactionModel(
        walletId: walletId,
        type: 'income',
        amount: 100000,
        category: 'gaji',
        date: '2025-06-01T00:00:00Z',
        note: 'Gaji bulanan',
      ));

      final result = await transactionService.getTransactionsByWallet(walletId);

      // Hasil yang diharapkan: list tidak kosong dan sesuai kategori
      expect(result, isA<List<TransactionModel>>());
      expect(result.length, greaterThan(0));
      expect(result.first.category, equals('gaji'));
    });

    test('Update transaction should return true', () async {
      // Tujuan: Menguji apakah transaksi dapat diperbarui
      final transaction = TransactionModel(
        walletId: 'mockWalletId',
        type: 'expense',
        amount: 20000,
        category: 'makanan',
        date: '2025-06-06T12:00:00Z',
        note: 'ayam goreng',
      );

      await transactionService.createTransaction(transaction);
      final created =
          (await transactionService.getTransactionsByWallet('mockWalletId'))
              .first;

      final updated = await transactionService.updateTransaction(
        created.id!,
        TransactionModel(
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
      final transaction = TransactionModel(
        walletId: 'mockWalletId',
        type: 'expense',
        amount: 10000,
        category: 'minuman',
        date: '2025-06-07T12:00:00Z',
        note: 'es teh',
      );

      await transactionService.createTransaction(transaction);
      final created =
          (await transactionService.getTransactionsByWallet('mockWalletId'))
              .first;

      final result = await transactionService.deleteTransaction(created.id!);

      // Hasil yang diharapkan: true
      expect(result, isTrue);
    });

    test('Get transaction summary should return total amount', () async {
      // Tujuan: Menguji ringkasan transaksi berdasarkan filter
      await transactionService.createTransaction(TransactionModel(
        walletId: 'mockWalletId',
        type: 'expense',
        amount: 5000,
        category: 'jajan',
        date: '2025-06-08T12:00:00Z',
        note: 'ciki',
      ));

      final summary = await transactionService
          .getTransactionSummary(filters: {'type': 'expense'});

      // Hasil yang diharapkan: total > 0
      expect(summary['summary']['total'], greaterThan(0));
    });
  });
}
