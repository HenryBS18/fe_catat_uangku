import 'package:fe_catat_uangku/bloc/arus_kas_bloc/arus_kas_bloc.dart';
import 'package:fe_catat_uangku/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_catat_uangku/models/arus_kas.dart';

class MockArusKasBloc extends Mock implements ArusKasBloc {}

class FakeArusKasEvent extends Fake implements ArusKasEvent {}

class FakeArusKasState extends Fake implements ArusKasState {}

void main() {
  late ArusKasBloc bloc;

  setUpAll(() {
    registerFallbackValue(FakeArusKasEvent());
    registerFallbackValue(FakeArusKasState());
  });

  setUp(() {
    bloc = MockArusKasBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<ArusKasBloc>.value(
          value: bloc,
          child: const ArusKasWidget(),
        ),
      ),
    );
  }

  /// Helper untuk menyetel state + stream dummy
  void setMockBlocState(ArusKasState state) {
    when(() => bloc.state).thenReturn(state);
    when(() => bloc.stream).thenAnswer((_) => const Stream.empty());
  }

  testWidgets('tidak menampilkan apa-apa saat initial', (tester) async {
    setMockBlocState(ArusKasInitial());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(SizedBox), findsOneWidget);
  });

  testWidgets('menampilkan CircularProgressIndicator saat loading',
      (tester) async {
    setMockBlocState(ArusKasLoading());

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('menampilkan pesan error saat terjadi error', (tester) async {
    setMockBlocState(ArusKasError('Terjadi kesalahan'));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.textContaining('❌'), findsOneWidget);
    expect(find.textContaining('Terjadi kesalahan'), findsOneWidget);
  });

  testWidgets('menampilkan data arus kas saat loaded', (tester) async {
    final dummyData =
        ArusKas(income: 200000, expense: 150000, netCashflow: 50000);

    setMockBlocState(ArusKasLoaded(dummyData));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('Arus Kas'), findsOneWidget);
    expect(find.text('Pemasukan'), findsOneWidget);
    expect(find.text('Pengeluaran'), findsOneWidget);
    expect(find.textContaining('Rp'), findsWidgets);
  });
}
