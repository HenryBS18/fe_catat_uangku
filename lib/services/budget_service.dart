part of 'services.dart';

class BudgetService {
  final BaseApi api = BaseApi();

  Future<List<BudgetModel>?> getAll() async {
    final Response response = await api.get('/budgets');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<BudgetModel> budgets = data
          .map((e) => BudgetModel(
                id: e['_id'],
                name: e['name'],
                amount: e['amount'],
                period: e['period'],
                categories: (e['categories'] as List<dynamic>).map((e) => e.toString()).toList(),
                walletIds: (e['walletIds'] as List<dynamic>).map((e) => e.toString()).toList(),
                usedAmount: e['usedAmount'],
                remainingAmount: e['remainingAmount'],
                percentUsed: e['percentUsed'],
                startDate: DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(e['startDate']),
              ))
          .toList();

      return budgets;
    }

    return null;
  }

  Future<bool> addNew(BudgetModel budget) async {
    final Response response = await api.post('/budgets', data: {
      'name': budget.name,
      'amount': budget.amount,
      'categories': budget.categories,
      'walletIds': budget.walletIds,
      'period': budget.period,
      'startDate': budget.startDate.toString(),
    });

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception('Gagal menambahkan anggaran');
  }
}
