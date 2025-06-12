part of 'payment_planned_dash_bloc.dart';

abstract class PlannedPaymentState {}

class PlannedPaymentInitial extends PlannedPaymentState {}

class PlannedPaymentLoading extends PlannedPaymentState {}

class PlannedPaymentLoaded extends PlannedPaymentState {
  final List<PlannedPayment> data;
  PlannedPaymentLoaded(this.data);
}

class PlannedPaymentError extends PlannedPaymentState {
  final String message;
  PlannedPaymentError(this.message);
}
