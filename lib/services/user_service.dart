import 'dart:convert';

import 'package:fe_catat_uangku/models/user.dart';
import 'package:fe_catat_uangku/utils/base_api.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  final BaseApi api = BaseApi();

  Future<bool> register(User user) async {
    final Response response = await api.post('/auth/register', data: {
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
    final Response response = await api.post('/auth/login', data: {
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

  Future<User> getUserProfile() async {
    final Response response = await api.get('/profile');
    print('✅ Status code: ${response.statusCode}');
    print('📦 Body: ${response.body}');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print('👉 Token di Flutter: $token');
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);

      return User(
        email: data['email'],
        name: data['name'],
        isPremium: data['isPremium'] ?? false,
        createdAt: data['createdAt'] != null
            ? DateTime.parse(data['createdAt'])
            : null,
      );
    }

    final Map<String, dynamic> error = jsonDecode(response.body);
    throw Exception(error['message'] ?? 'Gagal mengambil profil');
  }
}
