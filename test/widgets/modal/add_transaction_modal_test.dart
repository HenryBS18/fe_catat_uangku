import 'package:fe_catat_uangku/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddTransactionPage Widget Test', () {
    testWidgets('Should display title and buttons correctly',
        (WidgetTester tester) async {
      await tester
          .pumpWidget(const MaterialApp(home: AddTransactionPageModal()));

      expect(find.text('Tambah Catatan'), findsOneWidget);
      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Expense'), findsOneWidget);
    });

    testWidgets('Should change selected type on tap',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddTransactionPage()));

      await tester.tap(find.text('Expense'));
      await tester.pumpAndSettle();

      final expenseButton = tester.widget<ElevatedButton>(
          find.widgetWithText(ElevatedButton, 'Expense'));
      expect(expenseButton.style?.backgroundColor?.resolve({}),
          equals(Colors.red));
    });

    testWidgets('Should input amount and show formatted result',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddTransactionPage()));

      final amountField = find.byType(TextField).first;
      await tester.enterText(amountField, '10000');
      await tester.pumpAndSettle();

      expect(
        find.byWidgetPredicate((widget) =>
            widget is EditableText &&
            widget.controller.text.contains('10.000')),
        findsOneWidget,
      );
    });
    testWidgets('Should display title and buttons correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddTransactionPage()));

      expect(find.text('Tambah Catatan'), findsOneWidget);
      expect(find.text('Income'), findsOneWidget);
      expect(find.text('Expense'), findsOneWidget);
    });

    testWidgets('Should open WalletSelectionModal when wallet ListTile tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddTransactionPage()));

      await tester.tap(find.byIcon(Icons.account_balance_wallet));
      await tester.pumpAndSettle();

      expect(find.byType(WalletSelectionModal), findsOneWidget);
    });

    testWidgets(
        'Should open CategorySelectionModal when category ListTile tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddTransactionPage()));

      await tester.tap(find.byIcon(Icons.category));
      await tester.pumpAndSettle();

      expect(find.byType(CategorySelectionModal), findsOneWidget);
    });

    testWidgets('Should open NotesSectionModal when note row tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: AddTransactionPage()));

      await tester.tap(find.byIcon(Icons.message));
      await tester.pumpAndSettle();

      expect(find.byType(NotesSectionModal), findsOneWidget);
    });
  });
}
