import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_catat_uangku/services/wallet_service.dart';

part 'wallet_trend_event.dart';
part 'wallet_trend_state.dart';

class WalletTrendBloc extends Bloc<WalletTrendEvent, WalletTrendState> {
  final WalletService walletService;

  WalletTrendBloc(this.walletService) : super(WalletTrendInitial()) {
    on<FetchWalletTrend>((event, emit) async {
      emit(WalletTrendLoading());
      try {
        final data =
            await walletService.getWalletTrend(event.walletId, period: 30);
        emit(WalletTrendLoaded(
          trend: data['trend'] ?? [],
          currentBalance: data['currentBalance'] ?? 0,
        ));
      } catch (e) {
        emit(WalletTrendError(e.toString()));
      }
    });
  }
}
