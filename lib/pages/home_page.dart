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
            Container(
              decoration: BoxDecoration(
                color: Color(0xff20C997),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 76,
                        height: 76,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello,',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Putra Taufik',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Add & Active Wallet Cards
                  Row(
                    children: [
                      // Tambahkan Dompet
                      Container(
                        width: 150,
                        height: 150,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: CustomColors.primary,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tambahkan Dompet',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff565656),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Example Active Wallet
                      Container(
                        width: 150,
                        height: 150,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: CustomColors.primary,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(
                                Icons.wallet,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Uang Tunai',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Rp 1.000.000',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Chart Tren Saldo
            ChartTrenWidget(),
            const SizedBox(height: 16),
            // // Placeholder: Pengeluaran Teratas widget
            // PengeluaranTeratasWidget(),
            // const SizedBox(height: 16),
            // // Placeholder: Catatan Terakhir widget
            // CatatanTerakhirWidget(),
            // const SizedBox(height: 16),
            // // Placeholder: Rencana Pembayaran mendatang widget
            // RencanaPembayaranWidget(),
            // const SizedBox(height: 16),
            // // Placeholder: Anggaran widget
            // AnggaranWidget(),
            // const SizedBox(height: 16),
            // // Placeholder: Arus Kas widget
            // ArusKasWidget(),
            // const SizedBox(height: 16),
            // // Placeholder: Daftar Pengeluaran widget
            // DaftarPengeluaranWidget(),
          ],
        ),
      ),
    );
  }
}
