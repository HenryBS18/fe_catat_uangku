part of 'pages.dart';

class PaymentPlanningPage extends StatefulWidget {
  const PaymentPlanningPage({Key? key}) : super(key: key);

  @override
  _PaymentPlanningPageState createState() => _PaymentPlanningPageState();
}

class _PaymentPlanningPageState extends State<PaymentPlanningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rencana Pembayaran', style: TextStyle(fontWeight: FontWeight.bold))),
      body: Stack(
        children: [
          BlocBuilder<PaymentPlanningBloc, PaymentPlanningState>(
            builder: (context, state) {
              if (state is PaymentPlanningList) {
                return ListView.builder(
                  itemCount: state.paymentPlannings.length,
                  itemBuilder: (context, index) {
                    return PaymentPlanningItem(paymentPlanning: state.paymentPlannings[index]);
                  },
                );
              }

              return Center(child: Text('Tidak ada rencana pembayaran'));
            },
          ),
          Positioned(
            bottom: 32,
            right: 32,
            child: FloatingActionButton(
              shape: CircleBorder(),
              onPressed: () {
                Navigator.pushNamed(context, '/add-payment-planning-page');
              },
              child: Icon(Icons.add, size: 32),
            ),
          )
        ],
      ),
    );
  }
}
