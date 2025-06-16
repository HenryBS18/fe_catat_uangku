import 'dart:convert';
import 'package:fe_catat_uangku/models/wallet.dart';
import 'package:http/http.dart';
import 'package:fe_catat_uangku/utils/base_api.dart';

class WalletService {
  final BaseApi api = BaseApi(prefix: '/wallets');

  WalletModel fromJson(Map<String, dynamic> json) {
    return WalletModel(
      id: json['_id'],
      name: json['name'],
      balance: json['balance'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson(WalletModel wallet) {
    return {
      'name': wallet.name,
      'balance': wallet.balance,
    };
  }

  Future<List<WalletModel>> getWallets() async {
    final Response response = await api.get('/');
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => fromJson(json)).toList();
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message']);
    }
  }

  Future<bool> createWallet(WalletModel wallet) async {
    final Response response = await api.post('/', data: toJson(wallet));
    return response.statusCode == 201;
  }

  Future<Map<String, dynamic>> getWalletTrend(String walletId,
      {int period = 30}) async {
    final Response response = await api.get('/$walletId/trend?period=$period');

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      return body['data'];
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Gagal mengambil tren saldo wallet');
    }
  }

  Future<WalletModel> getWalletById(String walletId) async {
    final Response response = await api.get('/$walletId');
    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      return fromJson(json);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Gagal mengambil dompet');
    }
  }

  Future<bool> updateWallet(WalletModel wallet) async {
    final Response response =
        await api.put('/${wallet.id}', data: toJson(wallet));
    if (response.statusCode == 200) {
      return true; // atau return fromJson(jsonDecode(response.body)['wallet']);
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Gagal memperbarui dompet');
    }
  }

  Future<bool> deleteWallet(String walletId) async {
    final Response response = await api.delete('/$walletId');
    if (response.statusCode == 200) {
      return true;
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? 'Gagal menghapus dompet');
    }
  }
}
