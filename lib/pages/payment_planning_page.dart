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
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/payment-planning-detail-page');
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.live_tv, color: Colors.white, size: 32),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Langganan Netflix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(
                                'Hiburan',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Setiap bulan pada tanggal 12',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Uang Tunai',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '-Rp 150.000',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            '12 juni',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/payment-planning-detail-page');
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide())),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.live_tv, color: Colors.white, size: 32),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Langganan Netflix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              Text(
                                'Hiburan',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Setiap bulan pada tanggal 12',
                                style: TextStyle(fontSize: 12),
                              ),
                              Text(
                                'Uang Tunai',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '-Rp 150.000',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Text(
                            '12 juni',
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            bottom: 32,
            right: 32,
            child: FloatingActionButton(
              shape: CircleBorder(),
              onPressed: () {},
              child: Icon(Icons.add, size: 32),
            ),
          )
        ],
      ),
    );
  }
}
