part of 'wallet_trend_bloc.dart';

sealed class WalletTrendEvent {}

class FetchWalletTrend extends WalletTrendEvent {
  final String walletId;

  FetchWalletTrend(this.walletId);
}
