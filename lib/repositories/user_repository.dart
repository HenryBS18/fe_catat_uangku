part of 'repository.dart';

class UserRepository {
Future<String?> login(String email, String password) async {
  User user = User(email: email, password: password);

  try {

    PostResponse response = await apiServices.getPostApiResponse(
      '/api/users/login',
      user.toJson(),
    );

    if (response.body['token'] != null) {
      Const.auth = response.body['token'];
      Const.userId = response.body['user']['id'] ?? '';

      return 'Login berhasil'; 
    } else {
      String errorMessage = response.body['message'] ?? 'Login gagal: Tidak ada pesan kesalahan';
      return errorMessage; 
    }
  } catch (e) {
  
    return 'Login error: ${e.toString()}';
  }
}



  Future<String?> register(String email, String password, String name) async {
    User user = User(email: email, password: password, name: name);

    try {
      PostResponse response = await apiServices.getPostApiResponse(
        '/api/users/register',
        user.toJson(),
      );

      if (response.body['success'] == true) {
        Const.userId = response.body['payload']['userId'] ?? '';
        Const.auth = response.headers['authorization'] ?? '';
      }

      final List messages = response.body['messages'] ?? [];
      return messages.isNotEmpty ? messages[0].toString() : 'Tidak ada pesan dari API';
    } catch (e) {
      return 'Register error: ${e.toString()}';
    }
  }
}
