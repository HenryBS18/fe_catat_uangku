part of 'pages.dart';

class PaymentPlanningDetailPage extends StatefulWidget {
  const PaymentPlanningDetailPage({Key? key}) : super(key: key);

  @override
  _PaymentPlanningDetailPageState createState() => _PaymentPlanningDetailPageState();
}

class _PaymentPlanningDetailPageState extends State<PaymentPlanningDetailPage> {
  final PageController pageController = PageController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Rencana',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [TextButton(onPressed: () {}, child: Text('Edit')), const SizedBox(width: 16)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<PaymentPlanningDetailBloc, PaymentPlanningDetailState>(
                  builder: (context, state) {
                    if (state is PaymentPlanningDetail) {
                      return Container(
                        width: double.infinity,
                        height: 210,
                        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 160,
                              child: PageView.builder(
                                controller: pageController,
                                itemCount: 2,
                                onPageChanged: (index) {
                                  setState(() {
                                    currentIndex = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return _buildCard(state.paymentPlanning)[index];
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            DotsIndicator(
                              dotsCount: 2,
                              position: currentIndex,
                              color: Colors.black,
                              size: const Size(4, 4),
                              activeColor: CustomColors.primary,
                              activeSize: const Size(8, 8),
                            ),
                          ],
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
                const SizedBox(height: 32),
                Text('Tinjauan pembayaran'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide()),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '12 juni 2025',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.timer, color: Colors.blue.shade700),
                    const SizedBox(width: 2),
                    Text(
                      'Jatuh tempo dalam 10 hari',
                      style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade700,
                      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      fixedSize: Size(106, 32),
                    ),
                    child: Text(
                      'Bayar',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide()),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '12 juni 2025',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.timer),
                        const SizedBox(width: 2),
                        Text(
                          'Dibayar 12 mei 2025',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Text(
                      '-Rp 150.000',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildCard(PaymentPlanning paymentPlanning) {
    return [
      Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.live_tv, color: Colors.white, size: 64),
          ),
          const SizedBox(height: 8),
          Text(
            paymentPlanning.title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            paymentPlanning.category,
            style: TextStyle(fontSize: 12),
          ),
          Text(
            '-Rp ${paymentPlanning.amount}',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Ulangi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Setiap ${paymentPlanning.frequency} pada tanggal ${DateFormat('dd').format(paymentPlanning.paymentDate)}'),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Dompet',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(paymentPlanning.walletId ?? ''),
            ],
          ),
          const SizedBox(height: 16),
          if (paymentPlanning.description.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Catatan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(paymentPlanning.description),
              ],
            ),
        ],
      ),
    ];
  }
}
