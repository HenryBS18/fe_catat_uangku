import 'dart:convert';
import 'package:http/http.dart' as http;

class PostResponse {
  final Map<String, dynamic> body;
  final Map<String, String> headers;

  PostResponse({required this.body, required this.headers});
}

class ApiServices {
  static final ApiServices _instance = ApiServices._internal();
  factory ApiServices() => _instance;
  ApiServices._internal();

  // Base URL untuk server
  final String baseUrl = 'http://18.136.213.206:3000';

  Future<PostResponse> getPostApiResponse(String path, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$path');
    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    final body = json.decode(resp.body) as Map<String, dynamic>;

    return PostResponse(body: body, headers: resp.headers);
  }
  Future<List<dynamic>> getApiResponse(String path) async {
  final uri = Uri.parse('$baseUrl$path');
  final response = await http.get(uri);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    if (data is List) {
      return data;
    } else {
      throw Exception('Response is not a list');
    }
  } else {
    throw Exception('Failed to load data: ${response.statusCode}');
  }
}
}

final apiServices = ApiServices();
