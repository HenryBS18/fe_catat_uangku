import 'package:flutter/material.dart';
import 'package:fe_catat_uangku/pages/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // // Opsi 1: langsung pakai home
      // home: RegisterPage(),

      // Opsi 2: pakai named routes
      initialRoute: '/register',
      routes: {
        '/splash': (_)   => SplashscreenPage(),
        '/register': (_)     => AuthPage(),
        '/login': (_)    => AuthPage(),
        '/home': (_)     => HomePage(),
     
        
      },

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
    );
  }
}
