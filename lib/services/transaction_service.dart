import 'dart:convert';
import 'dart:io';
import 'package:fe_catat_uangku/models/transaction.dart';
import 'package:fe_catat_uangku/utils/base_api.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class TransactionService {
  final BaseApi api = BaseApi();

  Future<bool> createTransaction(TransactionModel transaction) async {
    final data = {
      'walletId': transaction.walletId,
      'type': transaction.type,
      'amount': transaction.amount,
      'category': transaction.category,
      'date': transaction.date,
      'note': transaction.note,
    };

    final Response response = await api.post('/transactions', data: data);
    final Map<String, dynamic> result = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return true;
    }

    throw Exception(result['message']);
  }

  Future<bool> updateTransaction(
      String id, TransactionModel transaction) async {
    final data = {
      'type': transaction.type,
      'amount': transaction.amount,
      'category': transaction.category,
      'date': transaction.date,
      'note': transaction.note,
    };

    final Response response = await api.put('/transactions/$id', data: data);
    final Map<String, dynamic> result = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return true;
    }

    throw Exception(result['message']);
  }

  Future<bool> deleteTransaction(String id) async {
    final Response response = await api.delete('/transactions/$id');
    final Map<String, dynamic> result = jsonDecode(response.body);

    if (response.statusCode != 200) {
      throw Exception(result['message']);
    }
    return true;
  }

  Future<List<TransactionModel>> getTransactionsByWallet(
      String walletId) async {
    final Response response = await api.get('/transactions/wallet/$walletId');
    final List<dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data
          .map((json) => TransactionModel(
                id: json['_id'],
                walletId: json['walletId'],
                type: json['type'],
                amount: json['amount'],
                category: json['category'],
                date: json['date'],
                note: json['note'],
              ))
          .toList();
    }

    throw Exception("Gagal mengambil transaksi");
  }

  Future<List<TransactionModel>> getAllTransactions(
      {String? type,
      String? category,
      String? startDate,
      String? endDate}) async {
    final queryParams = <String, String>{};
    if (type != null) queryParams['type'] = type;
    if (category != null) queryParams['category'] = category;
    if (startDate != null && endDate != null) {
      queryParams['startDate'] = startDate;
      queryParams['endDate'] = endDate;
    }

    final String queryString = Uri(queryParameters: queryParams).query;
    final Response response = await api
        .get('/transactions${queryString.isNotEmpty ? '?$queryString' : ''}');
    final List<dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data
          .map((json) => TransactionModel(
                id: json['_id'],
                walletId: json['walletId'],
                type: json['type'],
                amount: json['amount'],
                category: json['category'],
                date: json['date'],
                note: json['note'],
              ))
          .toList();
    }

    throw Exception("Gagal mengambil semua transaksi");
  }

  Future<TransactionModel> getTransactionById(String id) async {
    final Response response = await api.get('/transactions/$id');
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return TransactionModel(
        id: data['_id'],
        walletId: data['walletId'],
        type: data['type'],
        amount: data['amount'],
        category: data['category'],
        date: data['date'],
        note: data['note'],
      );
    }

    throw Exception("Gagal mengambil transaksi");
  }

  Future<Map<String, dynamic>> getTransactionSummary(
      {Map<String, String>? filters}) async {
    final String queryString =
        filters != null ? Uri(queryParameters: filters).query : '';
    final Response response = await api.get(
        '/transactions/summary${queryString.isNotEmpty ? '?$queryString' : ''}');
    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return data;
    }

    throw Exception("Gagal mengambil summary transaksi");
  }

  Future<Map<String, dynamic>> scanReceipt(File imageFile) async {
    final stream = http.ByteStream(imageFile.openRead());
    final length = await imageFile.length();
    final mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
    final typeParts = mimeType.split('/');

    final multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: imageFile.path.split('/').last,
      contentType: MediaType(typeParts[0], typeParts[1]), // ⬅️ ini penting!
    );

    final response = await api.postMultipart(
      '/scan-receipt',
      files: [multipartFile],
    );

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final Map<String, dynamic> result = jsonDecode(responseBody);
      return result['transaction']; // contains: amount, category, date, note
    } else {
      final errorBody = await response.stream.bytesToString();
      final decodedError = jsonDecode(errorBody);
      throw Exception(decodedError['error'] ?? 'Gagal membaca nota');
    }
  }
}
