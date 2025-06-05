import 'package:flutter_test/flutter_test.dart';
import 'package:fe_catat_uangku/models/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_transaction_service.dart';

void main() {
  late MockTransactionService transactionService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    transactionService = MockTransactionService();
  });

  group('Mock Test - TransactionService', () {
    test('Create transaction should return true', () async {
      final transaction = TransactionModel(
        walletId: 'mockWalletId',
        type: 'expense',
        amount: 15000,
        category: 'makanan',
        date: '2025-06-05T12:00:00Z',
        note: 'ayam penyet',
      );

      final result = await transactionService.createTransaction(transaction);

      expect(result, isTrue);
    });

    test('Get transaction by wallet should return non-empty list', () async {
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
      expect(result, isA<List<TransactionModel>>());
      expect(result.length, greaterThan(0));
      expect(result.first.category, equals('gaji'));
    });

    test('Update transaction should return true', () async {
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
          ));

      expect(updated, isTrue);
    });

    test('Delete transaction should return true', () async {
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
      expect(result, isTrue);
    });

    test('Get transaction summary should return total amount', () async {
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
      expect(summary['summary']['total'], greaterThan(0));
    });
  });
}
