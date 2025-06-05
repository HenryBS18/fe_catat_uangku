import 'package:fe_catat_uangku/pages/pages.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/payment-planning-page': (context) => const PaymentPlanningPage(),
  '/budget-planning-page': (context) => const BudgetPlanningPage(),
  '/payment-planning-detail-page': (context) => const PaymentPlanningDetailPage(),
  '/auth-page': (context) => const AuthPage(),
  '/tracsaction-history-page': (context) => const TransactionHistoryPage(),
};
