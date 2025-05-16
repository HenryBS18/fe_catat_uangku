library utils;

class Const {
  static String userId = '';
  static String auth = '';

  // Method untuk login dan menyimpan session
  static Future<void> signIn(String userId, String authToken) async {
    // Simpan ke session atau storage (contoh: SharedPreferences, secure storage)
    // Di sini bisa kamu simpan authToken dan userId ke storage lokal atau global.
    Const.userId = userId;
    Const.auth = authToken;

    // Misalnya kamu pakai shared_preferences
    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('userId', userId);
    // await prefs.setString('auth', authToken);
  }

  // Method untuk signOut (opsional)
  static Future<void> signOut() async {
    // Hapus data session atau storage
    // const prefs = await SharedPreferences.getInstance();
    // await prefs.remove('userId');
    // await prefs.remove('auth');
    userId = '';
    auth = '';
  }
}