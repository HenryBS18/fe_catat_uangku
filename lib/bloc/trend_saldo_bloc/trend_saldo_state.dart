part of 'trend_saldo_bloc.dart';

abstract class TrendSaldoState {}

class TrendSaldoInitial extends TrendSaldoState {}

class TrendSaldoLoading extends TrendSaldoState {}

class TrendSaldoLoaded extends TrendSaldoState {
  final List<TrendSaldo> data;
  final double total;
  TrendSaldoLoaded(this.data, this.total);
}

class TrendSaldoError extends TrendSaldoState {
  final String message;
  TrendSaldoError(this.message);
}
