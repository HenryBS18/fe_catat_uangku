part of 'top_expense_bloc.dart';

abstract class TopExpenseState {}

class TopExpenseInitial extends TopExpenseState {}

class TopExpenseLoading extends TopExpenseState {}

class TopExpenseLoaded extends TopExpenseState {
  final List<TopExpenseItem> data;
  TopExpenseLoaded(this.data);
}

class TopExpenseError extends TopExpenseState {
  final String message;
  TopExpenseError(this.message);
}
