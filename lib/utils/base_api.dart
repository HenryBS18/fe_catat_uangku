import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class BaseApi {
  final String baseUrl;
  final String prefix;

  BaseApi({
    this.baseUrl = 'https://catatuangku.site/api',
    this.prefix = '',
  });

  Future<http.Response> get(String endpoint,
      {Map<String, String>? headers}) async {
    return await http.get(_processUri(endpoint),
        headers: await _checkHeaders(headers));
  }

  Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    return await http.post(_processUri(endpoint),
        headers: await _checkHeaders(headers), body: _processBody(data));
  }

  Future<http.Response> put(String endpoint,
      {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    return await http.put(_processUri(endpoint),
        headers: await _checkHeaders(headers), body: _processBody(data));
  }

  Future<http.Response> patch(String endpoint,
      {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    return await http.patch(_processUri(endpoint),
        headers: await _checkHeaders(headers), body: _processBody(data));
  }

  Future<http.Response> delete(String endpoint,
      {Map<String, dynamic>? data, Map<String, String>? headers}) async {
    return await http.delete(_processUri(endpoint),
        headers: await _checkHeaders(headers), body: _processBody(data));
  }

  Future<http.StreamedResponse> postMultipart(
    String endpoint, {
    Map<String, String>? headers,
    bool? includeToken,
    List<http.MultipartFile>? files,
    Map<String, String>? fields,
  }) async {
    final Uri uri = _processUri(endpoint);
    Map<String, String> finalHeaders = await _checkHeaders(headers);
    finalHeaders.remove('Content-Type');

    final http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.headers.addAll(finalHeaders);

    if (fields != null) {
      request.fields.addAll(fields);
    }

    if (files != null && files.isNotEmpty) {
      request.files.addAll(files);
    } else {
      throw Exception("Tidak ada file");
    }

    return await request.send();
  }

  Uri _processUri(String endpoint) => Uri.parse('$baseUrl$prefix$endpoint');

  Future<Map<String, String>> _checkHeaders(
      Map<String, String>? headers) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');

    Map<String, String> finalHeaders;

    if (headers != null) {
      finalHeaders = {
        'Content-Type': 'application/json',
        ...headers,
      };
    } else {
      finalHeaders = {
        'Content-Type': 'application/json',
      };
    }

    if (token != null) {
      finalHeaders['Authorization'] = 'Bearer $token';
    }

    return finalHeaders;
  }

  Object? _processBody(Map<String, dynamic>? data) =>
      data != null ? jsonEncode(data) : null;
}
