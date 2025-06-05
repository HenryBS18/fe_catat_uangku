import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fe_catat_uangku/services/user_service.dart';
import 'package:fe_catat_uangku/models/user.dart';

import 'mocks.mocks.dart';

void main() {
  late MockBaseApi mockApi;
  late UserService userService;

  setUp(() {
    mockApi = MockBaseApi();
    userService = UserService(api: mockApi);
    SharedPreferences.setMockInitialValues({}); // reset prefs sebelum test
  });

  group('UserService login', () {
    test('login berhasil', () async {
      final user = User(email: 'test@example.com', password: '123456');

      when(mockApi.post('/users/login', data: anyNamed('data'))).thenAnswer(
        (_) async => Response(jsonEncode({'token': 'token123'}), 200),
      );

      final result = await userService.login(user);

      expect(result, true);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('token'), 'token123');

      verify(mockApi.post('/users/login', data: {
        'email': 'test@example.com',
        'password': '123456',
      })).called(1);
    });

    test('login gagal karena password salah', () async {
      final user = User(email: 'test@example.com', password: 'wrongpass');

      when(mockApi.post('/users/login', data: anyNamed('data'))).thenAnswer(
        (_) async => Response(jsonEncode({'message': 'Unauthorized'}), 401),
      );

      expect(() async => await userService.login(user),
          throwsA(isA<Exception>()));

      verify(mockApi.post('/users/login', data: {
        'email': 'test@example.com',
        'password': 'wrongpass',
      })).called(1);
    });
  });

  group('UserService register', () {
    test('register berhasil', () async {
      final user = User(name: 'Test User', email: 'new@example.com', password: '123456');

      when(mockApi.post('/users/register', data: anyNamed('data'))).thenAnswer(
        (_) async => Response(jsonEncode({'token': 'token456'}), 201),
      );

      final result = await userService.register(user);

      expect(result, true);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('token'), 'token456');

      verify(mockApi.post('/users/register', data: {
        'name': 'Test User',
        'email': 'new@example.com',
        'password': '123456',
      })).called(1);
    });

    test('register gagal karena email sudah ada', () async {
      final user = User(name: 'Test User', email: 'exists@example.com', password: '123456');

      when(mockApi.post('/users/register', data: anyNamed('data'))).thenAnswer(
        (_) async => Response(jsonEncode({'message': 'Email already exists'}), 400),
      );

      expect(() async => await userService.register(user),
          throwsA(isA<Exception>()));

      verify(mockApi.post('/users/register', data: {
        'name': 'Test User',
        'email': 'exists@example.com',
        'password': '123456',
      })).called(1);
    });
  });
}
