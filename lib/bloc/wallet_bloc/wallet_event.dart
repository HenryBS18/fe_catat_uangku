part of 'wallet_bloc.dart';

sealed class WalletEvent {}

class FetchWallets extends WalletEvent {}

class FetchWalletById extends WalletEvent {
  final String walletId;
  FetchWalletById(this.walletId);
}
