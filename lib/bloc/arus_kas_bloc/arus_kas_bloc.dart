import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_catat_uangku/models/arus_kas.dart';
import 'package:fe_catat_uangku/services/arus_kas_service.dart';

part 'arus_kas_event.dart';
part 'arus_kas_state.dart';

class ArusKasBloc extends Bloc<ArusKasEvent, ArusKasState> {
  final ArusKasService service;
  ArusKasBloc(this.service) : super(ArusKasInitial()) {
    on<LoadArusKas>((event, emit) async {
      emit(ArusKasLoading());
      try {
        final result = await service.fetchArusKas();
        emit(ArusKasLoaded(result));
      } catch (e) {
        emit(ArusKasError(e.toString()));
      }
    });
  }
}
