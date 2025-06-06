part of 'wallet_bloc.dart';

sealed class WalletState {}

final class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final List<WalletModel> wallets;

  WalletLoaded(this.wallets);
}

class WalletError extends WalletState {
  final String message;

  WalletError(this.message);
}
