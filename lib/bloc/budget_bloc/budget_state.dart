part of 'budget_bloc.dart';

abstract class BudgetState {}

class BudgetInitial extends BudgetState {}

class BudgetList extends BudgetState {
  final List<BudgetModel> budgets;

  BudgetList({required this.budgets});
}
