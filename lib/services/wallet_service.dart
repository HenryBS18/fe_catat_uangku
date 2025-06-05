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

  // Tambahan (jika nanti diperlukan)
  Future<bool> createWallet(WalletModel wallet) async {
    final Response response = await api.post('/', data: toJson(wallet));
    return response.statusCode == 201;
  }
}
