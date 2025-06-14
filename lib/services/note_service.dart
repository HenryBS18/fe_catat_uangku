import 'dart:convert';
import 'dart:io';
import 'package:fe_catat_uangku/models/note.dart';
import 'package:fe_catat_uangku/utils/base_api.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class NoteService {
  final BaseApi api = BaseApi();

  Future<bool> createNote(NoteModel transaction) async {
    final data = {
      'walletId': transaction.walletId,
      'type': transaction.type,
      'amount': transaction.amount,
      'category': transaction.category,
      'date': transaction.date,
      'note': transaction.note,
    };

    final Response response = await api.post('/notes', data: data);

    if (response.statusCode == 201) {
      return true;
    }

    final result = jsonDecode(response.body);
    throw Exception(result['message'] ?? 'Gagal membuat catatan');
  }

  Future<bool> updateNote(String id, NoteModel transaction) async {
    final data = {
      'type': transaction.type,
      'amount': transaction.amount,
      'category': transaction.category,
      'date': transaction.date,
      'note': transaction.note,
    };

    final Response response = await api.put('/notes/$id', data: data);

    if (response.statusCode == 200) {
      return true;
    }

    final result = jsonDecode(response.body);
    throw Exception(result['message'] ?? 'Gagal memperbarui catatan');
  }

  Future<bool> deleteNote(String id) async {
    final Response response = await api.delete('/notes/$id');

    if (response.statusCode == 200) {
      return true;
    }

    final result = jsonDecode(response.body);
    throw Exception(result['message'] ?? 'Gagal menghapus catatan');
  }

  Future<List<NoteModel>> getNotesByWallet(String walletId) async {
    final Response response = await api.get('/notes/wallet/$walletId');

    if (response.statusCode == 200) {
      final dynamic decoded = jsonDecode(response.body);
      if (decoded is List) {
        return decoded.map((json) => NoteModel.fromJson(json)).toList();
      } else {
        throw Exception('Response bukan berupa list');
      }
    }

    throw Exception("Gagal mengambil catatan berdasarkan wallet");
  }

  Future<List<NoteModel>> getAllNotes({
    String? type,
    String? category,
    String? startDate,
    String? endDate,
  }) async {
    final queryParams = <String, String>{};
    if (type != null) queryParams['type'] = type;
    if (category != null) queryParams['category'] = category;
    if (startDate != null && endDate != null) {
      queryParams['startDate'] = startDate;
      queryParams['endDate'] = endDate;
    }

    final queryString = Uri(queryParameters: queryParams).query;
    final Response response = await api.get(
        '/notes${queryString.isNotEmpty ? '?$queryString' : ''}');

    if (response.statusCode == 200) {
      final dynamic decoded = jsonDecode(response.body);
      if (decoded is List) {
        return decoded.map((json) => NoteModel.fromJson(json)).toList();
      } else {
        throw Exception('Response bukan berupa list');
      }
    }

    throw Exception("Gagal mengambil semua catatan");
  }

  Future<NoteModel> getNoteById(String id) async {
    final Response response = await api.get('/notes/$id');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return NoteModel.fromJson(data);
    }

    throw Exception("Gagal mengambil catatan");
  }

  Future<Map<String, dynamic>> getNoteSummary({Map<String, String>? filters}) async {
    final queryString =
        filters != null ? Uri(queryParameters: filters).query : '';
    final Response response =
        await api.get('/notes/summary${queryString.isNotEmpty ? '?$queryString' : ''}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data;
    }

    throw Exception("Gagal mengambil summary catatan");
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
      contentType: MediaType(typeParts[0], typeParts[1]),
    );

    final response = await api.postMultipart('/scan-receipt', files: [multipartFile]);
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final decoded = jsonDecode(responseBody);
      if (decoded['note'] is Map<String, dynamic>) {
        return decoded['note'];
      } else {
        throw Exception("Field 'note' kosong atau tidak sesuai format");
      }
    } else {
      final decodedError = jsonDecode(responseBody);
      throw Exception(decodedError['error'] ?? 'Gagal membaca nota');
    }
  }

  Future<Map<String, dynamic>> voiceToNote(String text) async {
    final response = await api.post('/voice-receipt/', data: {'text': text});

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body['note'] is Map<String, dynamic>) {
        return body['note'];
      } else {
        throw Exception("Field 'note' tidak ditemukan atau invalid");
      }
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['error'] ?? 'Gagal memproses input suara');
    }
  }
}
