import 'package:dio/dio.dart';
import 'package:fe_catat_uangku/models/budget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetService {
  final Dio dio = Dio();

  Future<List<BudgetModel>> fetchBudgets() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final response = await dio.get(
      'https://www.catatuangku.site/api/budgets/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    final data = response.data as List;
    return data.map((e) => BudgetModel.fromJson(e)).toList();
  }
}
