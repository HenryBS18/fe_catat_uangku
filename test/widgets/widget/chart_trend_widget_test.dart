import 'package:fe_catat_uangku/bloc/trend_saldo_bloc/trend_saldo_bloc.dart';
import 'package:fe_catat_uangku/models/trend_saldo.dart';
import 'package:fe_catat_uangku/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockTrendSaldoBloc extends Mock implements TrendSaldoBloc {}

class FakeTrendSaldoEvent extends Fake implements TrendSaldoEvent {}

class FakeTrendSaldoState extends Fake implements TrendSaldoState {}

void main() {
  late TrendSaldoBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeTrendSaldoEvent());
    registerFallbackValue(FakeTrendSaldoState());
  });

  setUp(() {
    bloc = MockTrendSaldoBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<TrendSaldoBloc>.value(
          value: bloc,
          child: const ChartTrenWidget(),
        ),
      ),
    );
  }

  void setMockState(TrendSaldoState state) {
    when(() => bloc.state).thenReturn(state);
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
  }

  testWidgets('menampilkan CircularProgressIndicator saat loading',
      (tester) async {
    setMockState(TrendSaldoLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('menampilkan pesan error saat terjadi error', (tester) async {
    setMockState(TrendSaldoError('Gagal ambil data'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Gagal ambil data'), findsOneWidget);
  });

  testWidgets('menampilkan data tren saldo saat loaded', (tester) async {
    final dummyList = List.generate(
      5,
      (i) => TrendSaldo(
        date: DateTime.now().subtract(Duration(days: 5 - i)),
        balance: (i + 1) * 1000000.0,
      ),
    );

    setMockState(TrendSaldoLoaded(dummyList, dummyList.last.balance));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Tren Saldo'), findsNWidgets(2)); // judul + legenda
    expect(find.text('HARI INI'), findsOneWidget);
    expect(find.textContaining('Rp'), findsWidgets);
  });

  testWidgets('menampilkan "Tidak ada data" saat list kosong', (tester) async {
    setMockState(TrendSaldoLoaded([], 0.0));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Tidak ada data'), findsWidgets);
  });
}
