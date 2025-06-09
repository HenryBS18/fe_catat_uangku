part of 'pages.dart';

class AddPaymentPlanningPage extends StatefulWidget {
  const AddPaymentPlanningPage({Key? key}) : super(key: key);

  @override
  _AddPaymentPlanningPageState createState() => _AddPaymentPlanningPageState();
}

class _AddPaymentPlanningPageState extends State<AddPaymentPlanningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Rencana Pembayaran'),
      ),
      backgroundColor: Colors.grey.shade400,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 16,
                        children: [
                          Icon(Icons.currency_bitcoin_outlined, size: 48),
                          Expanded(child: Input(label: 'Jumlah')),
                        ],
                      ),
                      const Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 16,
                        children: [
                          Icon(Icons.wallet_outlined, size: 48),
                          Expanded(child: Input(label: 'Akun')),
                        ],
                      ),
                      const Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 16,
                        children: [
                          Icon(Icons.note_outlined, size: 48),
                          Expanded(child: InputTextArea(label: 'Catatan', maxLines: 3)),
                        ],
                      ),
                      const Divider(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        spacing: 16,
                        children: [
                          Icon(Icons.calendar_month_outlined, size: 48),
                          Expanded(
                            child: InputDate(
                              label: 'Tanggal',
                              controller: TextEditingController(),
                              iconOn: false,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Button(title: 'Simpan'),
            )
          ],
        ),
      ),
    );
  }
}
