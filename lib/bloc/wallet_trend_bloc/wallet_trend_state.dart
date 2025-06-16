part of 'wallet_trend_bloc.dart';

sealed class WalletTrendState {}

class WalletTrendInitial extends WalletTrendState {}

class WalletTrendLoading extends WalletTrendState {}

class WalletTrendLoaded extends WalletTrendState {
  final List<dynamic> trend;
  final int currentBalance;

  WalletTrendLoaded({required this.trend, required this.currentBalance});
}

class WalletTrendError extends WalletTrendState {
  final String message;

  WalletTrendError(this.message);
}
