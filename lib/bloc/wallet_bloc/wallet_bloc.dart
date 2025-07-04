import 'package:fe_catat_uangku/services/wallet_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_catat_uangku/models/wallet.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletService walletService;

  WalletBloc(this.walletService) : super(WalletInitial()) {
    on<FetchWallets>((event, emit) async {
      emit(WalletLoading());
      try {
        final wallets = await walletService.getWallets();
        wallets.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        emit(WalletLoaded(wallets));
      } catch (e) {
        emit(WalletError(e.toString()));
      }
    });

    on<FetchWalletById>((event, emit) async {
      emit(WalletLoading());
      try {
        final wallet = await walletService.getWalletById(event.walletId);
        emit(WalletByIdLoaded(wallet));
      } catch (e) {
        emit(WalletError(e.toString()));
      }
    });
  }
}
