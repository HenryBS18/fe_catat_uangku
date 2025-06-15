import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/trend_saldo.dart';

class TrendSaldoService {
  Future<List<TrendSaldo>> fetchTrendData({int period = 30}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    if (token.isEmpty) throw Exception('User tidak terautentikasi');

    final dio = Dio(BaseOptions(
      baseUrl: 'https://www.catatuangku.site/',
      headers: {'Authorization': 'Bearer $token'},
      responseType: ResponseType.json,
    ));
    final resp = await dio.get('/api/dashboard/trend-saldo?period=$period');
    if (resp.statusCode == 200) {
      final data = resp.data['data'] as Map<String, dynamic>;
      final rawList = (data['trend'] as List)
          .map((e) => TrendSaldo.fromJson(e as Map<String, dynamic>))
          .toList();

      if (rawList.isEmpty) return [];

      rawList.sort((a, b) => a.date.compareTo(b.date));
      DateTime current = rawList.first.date;
      final DateTime end = rawList.last.date;
      List<TrendSaldo> fullList = [];
      double cumBalance = 0;
      while (!current.isAfter(end)) {
        final match = rawList.firstWhere(
          (t) =>
              t.date.year == current.year &&
              t.date.month == current.month &&
              t.date.day == current.day,
          orElse: () => TrendSaldo(date: current, balance: cumBalance),
        );
        cumBalance = match.balance;
        fullList.add(TrendSaldo(date: current, balance: cumBalance));
        current = current.add(Duration(days: 1));
      }
      return fullList;
    } else {
      final msg = resp.data['message'] ?? 'Error ${resp.statusCode}';
      throw Exception(msg);
    }
  }
}
