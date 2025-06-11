class SubscriptionResponse {
  final String orderId;
  final String paymentToken;
  final String paymentUrl;

  SubscriptionResponse({
    required this.orderId,
    required this.paymentToken,
    required this.paymentUrl,
  });
}
