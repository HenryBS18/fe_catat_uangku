import 'package:fe_catat_uangku/bloc/top_expense_bloc/top_expense_bloc.dart';
import 'package:fe_catat_uangku/models/top_expense.dart';
import 'package:fe_catat_uangku/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTopExpenseBloc extends Mock implements TopExpenseBloc {}

class FakeTopExpenseEvent extends Fake implements TopExpenseEvent {}

class FakeTopExpenseState extends Fake implements TopExpenseState {}

void main() {
  late TopExpenseBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeTopExpenseEvent());
    registerFallbackValue(FakeTopExpenseState());
  });

  setUp(() {
    bloc = MockTopExpenseBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<TopExpenseBloc>.value(
          value: bloc,
          child: const TopExpenseWidget(),
        ),
      ),
    );
  }

  void setMockState(TopExpenseState state) {
    when(() => bloc.state).thenReturn(state);
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
  }

  testWidgets('menampilkan CircularProgressIndicator saat loading',
      (tester) async {
    setMockState(TopExpenseLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('menampilkan pesan error saat terjadi error', (tester) async {
    setMockState(TopExpenseError('Gagal memuat'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.textContaining('❌'), findsOneWidget);
    expect(find.textContaining('Gagal memuat'), findsOneWidget);
  });

  testWidgets('menampilkan daftar pengeluaran saat loaded', (tester) async {
    final dummyData = [
      TopExpenseItem(category: 'Makanan', total: 150000),
      TopExpenseItem(category: 'Transportasi', total: 100000),
      TopExpenseItem(category: 'Hiburan', total: 80000),
    ];

    setMockState(TopExpenseLoaded(dummyData));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Pengeluaran teratas'), findsOneWidget);
    expect(find.text('Makanan'), findsOneWidget);
    expect(find.text('Transportasi'), findsOneWidget);
    expect(find.text('Hiburan'), findsOneWidget);
    expect(find.textContaining('Rp'), findsWidgets);
  });

  testWidgets('tidak menampilkan apa-apa saat initial', (tester) async {
    setMockState(TopExpenseInitial());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(SizedBox), findsOneWidget);
  });
}
