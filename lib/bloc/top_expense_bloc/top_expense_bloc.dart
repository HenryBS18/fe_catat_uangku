import 'package:fe_catat_uangku/models/top_expense.dart';
import 'package:fe_catat_uangku/services/top_expense_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_expense_event.dart';
part 'top_expense_state.dart';

class TopExpenseBloc extends Bloc<TopExpenseEvent, TopExpenseState> {
  final TopExpenseService service;
  TopExpenseBloc(this.service) : super(TopExpenseInitial()) {
    on<LoadTopExpense>((event, emit) async {
      emit(TopExpenseLoading());
      try {
        final result = await service.fetchTopExpenses();
        emit(TopExpenseLoaded(result));
      } catch (e) {
        emit(TopExpenseError(e.toString()));
      }
    });
  }
}
