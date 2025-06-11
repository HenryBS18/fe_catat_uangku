import 'dart:convert';

import 'package:fe_catat_uangku/models/subscription.dart';
import 'package:fe_catat_uangku/utils/base_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionService {
  final BaseApi api = BaseApi();

  /// Calls backend to create a subscription and returns [SubscriptionResponse]
  Future<SubscriptionResponse> createSubscription(double grossAmount) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await api.post(
      '/subscribe',
      data: {'gross_amount': grossAmount},
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      // Parse JSON into model here
      return SubscriptionResponse(
        orderId: json['orderId'] as String,
        paymentToken: json['paymentToken'] as String,
        paymentUrl: json['paymentUrl'] as String,
      );
    }

    throw Exception('Failed to create subscription: ${response.statusCode}');
  }
}
