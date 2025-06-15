import 'package:fe_catat_uangku/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:fe_catat_uangku/bloc/note_bloc/note_bloc.dart';
import 'package:fe_catat_uangku/services/note_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final NoteService noteService = NoteService();

Map<String, Widget Function(BuildContext)> routes = {
  '/': (context) => const SplashscreenPage(),
  '/login-page': (context) => const LoginPage(),
  '/register-page': (context) => const RegisterPage(),
  '/main-page': (context) => const MainPage(),
  '/payment-planning-page': (context) => const PaymentPlanningPage(),
  '/budget-planning-page': (context) => const BudgetPlanningPage(),
  '/payment-planning-detail-page': (context) => const PaymentPlanningDetailPage(),
  '/profile-page': (context) => const ProfilePage(),
  '/transaction-history-page': (context) => BlocProvider(
        create: (_) => NoteBloc(noteService)..add(FetchNotes()),
        child: const TransactionHistoryPage(),
      ),
  '/add-payment-planning-page': (context) => const AddPaymentPlanningPage(),
};
