part of 'payment_planning_detail_bloc.dart';

sealed class PaymentPlanningDetailState {}

final class PaymentPlanningDetailInitial extends PaymentPlanningDetailState {}

class PaymentPlanningDetail extends PaymentPlanningDetailState {
  final PaymentPlanning paymentPlanning;

  PaymentPlanningDetail({required this.paymentPlanning});
}
