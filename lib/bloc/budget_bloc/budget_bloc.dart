import 'package:fe_catat_uangku/models/budget.dart';
import 'package:fe_catat_uangku/services/budget_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'budget_event.dart';
part 'budget_state.dart';

class BudgetBloc extends Bloc<BudgetEvent, BudgetState> {
  final BudgetService service;
  BudgetBloc(this.service) : super(BudgetInitial()) {
    on<LoadBudgets>((event, emit) async {
      emit(BudgetLoading());
      try {
        final data = await service.fetchBudgets();
        emit(BudgetLoaded(data));
      } catch (e) {
        emit(BudgetError(e.toString()));
      }
    });
  }
}
