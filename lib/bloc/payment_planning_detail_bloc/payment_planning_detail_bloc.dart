import 'package:fe_catat_uangku/models/payment_planning.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_planning_detail_event.dart';
part 'payment_planning_detail_state.dart';

class PaymentPlanningDetailBloc extends Bloc<PaymentPlanningDetailEvent, PaymentPlanningDetailState> {
  PaymentPlanningDetailBloc() : super(PaymentPlanningDetailInitial()) {
    on<SetPaymentPlanningDetailEvent>((event, emit) {
      emit(PaymentPlanningDetail(paymentPlanning: event.paymentPlanning));
    });

    on<RemovePaymentPlanningDetailEvent>((event, emit) {
      emit(PaymentPlanningDetailInitial());
    });
  }
}
