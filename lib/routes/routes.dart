import 'package:fe_catat_uangku/pages/pages.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/main-page': (context) => const MainPage(),
  '/payment-planning-page': (context) => const PaymentPlanningPage(),
  '/budget-planning-page': (context) => const BudgetPlanningPage(),
  '/payment-planning-detail-page': (context) =>
      const PaymentPlanningDetailPage(),
  '/profile-page': (context) => const ProfilePage(),
};
