part of 'services.dart';

class PaymentPlanningService {
  final BaseApi api = BaseApi();

  Future<List<PaymentPlanning>?> getAll() async {
    final Response response = await api.get('/planned-payments');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<PaymentPlanning> paymentPlannings = data
          .map(
            (e) => PaymentPlanning(
              id: e['_id'],
              title: e['title'],
              description: e['description'],
              category: e['category'],
              amount: e['amount'],
              paymentDate: DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(e['payment_date']),
              frequency: e['recurring_type'],
              walletId: e['wallet_id'],
            ),
          )
          .toList();

      return paymentPlannings;
    }

    return null;
  }

  Future<bool> addNew(PaymentPlanning paymentPlanning) async {
    final Response response = await api.post('/planned-payments', data: {
      'wallet_id': paymentPlanning.walletId,
      'title': paymentPlanning.title,
      'description': paymentPlanning.description,
      'type': paymentPlanning.type,
      'category': paymentPlanning.category,
      'amount': paymentPlanning.amount,
      'payment_date': paymentPlanning.paymentDate.toString(),
      'recurring_type': paymentPlanning.frequency,
    });

    if (response.statusCode == 201) {
      return true;
    }

    throw Exception('Gagal membuat rencana pembayaran');
  }

  Future<PaymentPlanning?> getById(String id) async {
    final Response response = await api.get('/planned-payments/$id');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body)['plan'];

      return PaymentPlanning(
        id: data['_id'],
        title: data['title'],
        description: data['description'],
        category: data['category'],
        amount: data['amount'],
        paymentDate: DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').parse(data['payment_date']),
        frequency: data['recurring_type'],
        walletId: data['wallet_id'],
      );
    }

    return null;
  }

  Future<bool> pay(String id) async {
    final Response response = await api.post('/planned-payments/$id/pay');
    print(response.body);
    if (response.statusCode == 200) {
      return true;
    }

    throw Exception('Gagal membayar');
  }
}
