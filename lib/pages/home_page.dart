part of 'pages.dart';

// pastikan sudah di-setup untuk part

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catat Uangku',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Wallet & User Info
            HeaderWalletWidget(),
            const SizedBox(height: 16),
            ChartTrenWidget(),
            const SizedBox(height: 16),
            ArusKasWidget(),
            const SizedBox(height: 16),
            TopExpenseWidget(),
            const SizedBox(height: 16),
            PlannedPaymentDashWidget(),
            const SizedBox(height: 16),
            BudgetWidget()
          ],
        ),
      ),
    );
  }
}
