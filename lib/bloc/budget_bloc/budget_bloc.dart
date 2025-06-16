import 'package:fe_catat_uangku/models/budget.dart';
import 'package:fe_catat_uangku/services/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  BudgetBloc() : super(BudgetInitial()) {
    on<GetBudgetList>((event, emit) async {
      final BudgetService budgetService = BudgetService();
      final List<BudgetModel>? budgets = await budgetService.getAll();

      if (budgets != null) {
        emit(BudgetList(budgets: budgets));
      }
    });
  }
}
