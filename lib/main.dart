import 'package:fe_catat_uangku/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_catat_uangku/routes/routes.dart';
import 'package:fe_catat_uangku/utils/custom_colors.dart';
import 'package:fe_catat_uangku/services/wallet_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => WalletBloc(WalletService())..add(FetchWallets()),
        ),
      ],
      child: MaterialApp(
        title: 'Catat Uangku',
        theme: ThemeData(
          useMaterial3: true,
          appBarTheme: const AppBarTheme(color: Colors.white),
          colorScheme: const ColorScheme.light(
            primary: CustomColors.primary,
            surface: Colors.white,
          ),
        ),
        routes: routes,
        initialRoute: '/history-transaction-page',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
