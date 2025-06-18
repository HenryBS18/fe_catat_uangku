part of 'payment_planning_detail_bloc.dart';

sealed class PaymentPlanningDetailEvent {}

class SetPaymentPlanningDetailEvent extends PaymentPlanningDetailEvent {
  final PaymentPlanning paymentPlanning;

  SetPaymentPlanningDetailEvent({required this.paymentPlanning});
}

class RemovePaymentPlanningDetailEvent extends PaymentPlanningDetailEvent {}
