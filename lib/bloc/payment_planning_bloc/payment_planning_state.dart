part of 'payment_planning_bloc.dart';

sealed class PaymentPlanningState {}

final class PaymentPlanningInitial extends PaymentPlanningState {}

class PaymentPlanningList extends PaymentPlanningState {
  final List<PaymentPlanning> paymentPlannings;

  PaymentPlanningList({required this.paymentPlannings});
}
