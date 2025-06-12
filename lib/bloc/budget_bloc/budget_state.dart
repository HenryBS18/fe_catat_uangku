part of 'budget_bloc.dart';

abstract class BudgetState {}

class BudgetInitial extends BudgetState {}

class BudgetLoading extends BudgetState {}

class BudgetLoaded extends BudgetState {
  final List<BudgetModel> budgets;
  BudgetLoaded(this.budgets);
}

class BudgetError extends BudgetState {
  final String message;
  BudgetError(this.message);
}
