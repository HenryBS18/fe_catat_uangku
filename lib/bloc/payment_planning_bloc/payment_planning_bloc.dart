import 'package:fe_catat_uangku/models/payment_planning.dart';
import 'package:fe_catat_uangku/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_planning_event.dart';
part 'payment_planning_state.dart';

class PaymentPlanningBloc extends Bloc<PaymentPlanningEvent, PaymentPlanningState> {
  PaymentPlanningBloc() : super(PaymentPlanningInitial()) {
    on<GetPaymentPlanningListEvent>((event, emit) async {
      final PaymentPlanningService paymentPlanningService = PaymentPlanningService();
      final List<PaymentPlanning>? paymentPlannings = await paymentPlanningService.getAll();

      if (paymentPlannings != null) {
        emit(PaymentPlanningList(paymentPlannings: paymentPlannings));
      }
    });
  }
}
