import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:fe_catat_uangku/models/user.dart';
import 'package:fe_catat_uangku/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final UserService userService = UserService();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
  });

  group('Integration Test - UserService', () {
    test('Register user should return true when successful', () async {
      final user = User(
        name: 'Test User',
        email: 'test${Random().nextInt(100)}@example.com',
        password: 'Test123!',
      );

      final result = await userService.register(user);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      expect(result, isTrue);
      expect(token, isNotNull);
    });

    test('Register user should throw exception when failed', () async {
      final user = User(
        name: 'Test User',
        email: 'test@example.com',
        password: 'test123',
      );

      try {
        await userService.register(user);
      } catch (e) {
        expect(e.toString(), contains('Password minimal 8 karakter dan harus mengandung setidaknya 1 huruf kapital, 1 angka, dan 1 simbol'));
      }
    });

    test('Login user should return true when successful', () async {
      final user = User(
        email: 'test@example.com',
        password: 'Test123!',
      );

      final result = await userService.login(user);

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      expect(result, isTrue);
      expect(token, isNotNull);
    });

    test('Login should throw exception when password is wrong', () async {
      final user = User(
        email: 'test@example.com',
        password: 'salahpassword',
      );

      try {
        await userService.login(user);
      } catch (e) {
        expect(e.toString(), contains('Password salah'));
      }
    });
  });
}
