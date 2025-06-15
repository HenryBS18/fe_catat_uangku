import 'package:bloc/bloc.dart';
import 'package:fe_catat_uangku/models/planned_payment_dash.dart';
import 'package:fe_catat_uangku/services/planned_payment_dash_service.dart';

part 'payment_planned_dash_event.dart';
part 'payment_planned_dash_state.dart';

class PlannedPaymentDashBloc
    extends Bloc<PlannedPaymentDashEvent, PlannedPaymentState> {
  final PlannedPaymentDashService service;
  PlannedPaymentDashBloc(this.service) : super(PlannedPaymentInitial()) {
    on<LoadPlannedPayment>((event, emit) async {
      emit(PlannedPaymentLoading());
      try {
        final result = await service.fetchPlannedPayments();
        emit(PlannedPaymentLoaded(result));
      } catch (e) {
        emit(PlannedPaymentError(e.toString()));
      }
    });
  }
}
