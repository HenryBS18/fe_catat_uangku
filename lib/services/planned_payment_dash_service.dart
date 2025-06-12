import 'package:dio/dio.dart';
import 'package:fe_catat_uangku/models/planned_payment_dash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlannedPaymentDashService {
  Future<List<PlannedPayment>> fetchPlannedPayments() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    if (token.isEmpty) throw Exception('User tidak terautentikasi');

    final dio = Dio(BaseOptions(
      baseUrl: 'https://www.catatuangku.site/',
      headers: {'Authorization': 'Bearer $token'},
    ));

    final response = await dio.get('/api/dashboard/planned-payments');
    if (response.statusCode == 200 && response.data['success'] == true) {
      return (response.data['data'] as List)
          .map((e) => PlannedPayment.fromJson(e))
          .toList();
    } else {
      throw Exception(
          response.data['message'] ?? 'Gagal mengambil rencana pembayaran');
    }
  }
}
