import 'package:fe_catat_uangku/bloc/user_bloc/user_bloc.dart';
import 'package:fe_catat_uangku/bloc/wallet_bloc/wallet_bloc.dart';
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
  // Tangkap initial URI (cold start via catatuangku://…)
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
          create: (_) => UserProfileBloc(userService: UserService())
            ..add(FetchUserProfile()),
        )
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
