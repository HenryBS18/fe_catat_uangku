import 'package:bloc/bloc.dart';
import 'package:fe_catat_uangku/services/trend_saldo_service.dart';
import 'package:fe_catat_uangku/models/trend_saldo.dart';

part 'trend_saldo_event.dart';
part 'trend_saldo_state.dart';

class TrendSaldoBloc extends Bloc<TrendSaldoEvent, TrendSaldoState> {
  final TrendSaldoService service;
  TrendSaldoBloc(this.service) : super(TrendSaldoInitial()) {
    on<LoadTrendSaldo>((event, emit) async {
      emit(TrendSaldoLoading());
      try {
        final data = await service.fetchTrendData();
        final total = data.isNotEmpty ? data.last.balance : 0.0;
        emit(TrendSaldoLoaded(data, total));
      } catch (e) {
        emit(TrendSaldoError(e.toString()));
      }
    });
  }
}
