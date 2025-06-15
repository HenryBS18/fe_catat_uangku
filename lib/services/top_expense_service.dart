import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/top_expense.dart';

class TopExpenseService {
  Future<List<TopExpenseItem>> fetchTopExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    if (token.isEmpty) throw Exception('User tidak terautentikasi');

    final dio = Dio(BaseOptions(
      baseUrl: 'https://www.catatuangku.site/',
      headers: {'Authorization': 'Bearer $token'},
    ));

    final response = await dio.get('/api/dashboard/top-expenses');
    if (response.statusCode == 200 && response.data['success'] == true) {
      return (response.data['data'] as List)
          .map((e) => TopExpenseItem.fromJson(e))
          .toList();
    } else {
      throw Exception(
          response.data['message'] ?? 'Gagal mengambil data top expense');
    }
  }
}
