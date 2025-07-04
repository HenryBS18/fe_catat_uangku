import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/arus_kas.dart';

class ArusKasService {
  Future<ArusKas> fetchArusKas() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    if (token.isEmpty) throw Exception('User tidak terautentikasi');

    final dio = Dio(BaseOptions(
      baseUrl: 'https://www.catatuangku.site/',
      headers: {'Authorization': 'Bearer $token'},
    ));

    final response = await dio.get('/api/dashboard/arus-kas');
    if (response.statusCode == 200 && response.data['success'] == true) {
      return ArusKas.fromJson(response.data['data']);
    } else {
      throw Exception(
          response.data['message'] ?? 'Gagal mengambil data arus kas');
    }
  }
}
