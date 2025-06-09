import 'dart:convert';

import 'package:fe_catat_uangku/models/user.dart';
import 'package:fe_catat_uangku/utils/base_api.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final BaseApi api = BaseApi();

  Future<bool> register(User user) async {
    final Response response = await api.post('/users/register', data: {
      'name': user.name,
      'email': user.email,
      'password': user.password,
    });

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['token']);

      return true;
    }

    throw Exception(data['message']);
  }

  Future<bool> login(User user) async {
    final Response response = await api.post('/users/login', data: {
      'email': user.email,
      'password': user.password,
    });

    final Map<String, dynamic> data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final String token = data['token'];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', data['token']);
      print('Registration successful, token: $token');

      return true;
    }

    throw Exception(data['message']);
  }

  Future<bool> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    return true;
  }
}
