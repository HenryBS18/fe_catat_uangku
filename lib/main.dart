import 'package:fe_catat_uangku/bloc/arus_kas_bloc/arus_kas_bloc.dart';
import 'package:fe_catat_uangku/bloc/top_expense_bloc/top_expense_bloc.dart';
import 'package:fe_catat_uangku/bloc/trend_saldo_bloc/trend_saldo_bloc.dart';
import 'package:fe_catat_uangku/bloc/wallet_bloc/wallet_bloc.dart';
import 'package:fe_catat_uangku/services/arus_kas_service.dart';
import 'package:fe_catat_uangku/services/top_expense_service.dart';
import 'package:fe_catat_uangku/services/trend_saldo_service.dart';
import 'package:fe_catat_uangku/bloc/user_bloc/user_bloc.dart';
import 'package:fe_catat_uangku/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fe_catat_uangku/routes/routes.dart';
import 'package:fe_catat_uangku/utils/custom_colors.dart';
import 'package:fe_catat_uangku/services/wallet_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:uni_links3/uni_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  // Tangkap URI dari deep link (jika ada)
  try {
    final uri = await getInitialUri();
    debugPrint('🔄 [DEBUG main] getInitialUri: $uri');
  } catch (e) {
    debugPrint('❌ [DEBUG main] getInitialUri error: $e');
  }

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
        BlocProvider(
          create: (_) =>
              TrendSaldoBloc(TrendSaldoService())..add(LoadTrendSaldo()),
        ),
        BlocProvider(
          create: (_) => UserProfileBloc(userService: UserService())
            ..add(FetchUserProfile()),
        ),
        BlocProvider(
          create: (_) => ArusKasBloc(ArusKasService())..add(LoadArusKas()),
        ),
        BlocProvider(
          create: (_) =>
              TopExpenseBloc(TopExpenseService())..add(LoadTopExpense()),
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
        initialRoute: '/',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
