import 'package:fe_catat_uangku/routes/routes.dart';
import 'package:fe_catat_uangku/utils/custom_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catat Uangku',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(color: Colors.white),
        colorScheme: const ColorScheme.light(primary: CustomColors.primary, surface: Colors.white),
      ),
      routes: routes,
      initialRoute: '/main-page',
      debugShowCheckedModeBanner: false,
    );
  }
}
