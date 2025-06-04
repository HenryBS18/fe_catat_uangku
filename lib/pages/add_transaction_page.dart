part of 'pages.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  bool isIncome = true;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String? noteError;

  String selectedWallet = 'Tunai';
  String selectedCategory = 'Makanan & Minuman';
  DateTime selectedDate = DateTime.now();

  final List<String> dummyWallets = [
    'Tunai',
    'Bank BCA',
    'Bank Mandiri',
    'e-Wallet OVO',
  ];

  final List<String> dummyCategories = [
    'Makanan & Minuman',
    'Transportasi',
    'Belanja',
    'Tagihan Listrik',
    'Gaji',
    'Hadiah',
  ];

  @override
  void initState() {
    super.initState();
    noteController.addListener(() {
      setState(() {
        noteError =
            noteController.text.length > 50 ? 'Maksimal 50 karakter' : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0F55C3),
        centerTitle: true,
        title: const Text('Tambah Catatan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isIncome ? Colors.green : Colors.grey,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.zero,
                          bottomRight: Radius.zero,
                          topLeft: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () => setState(() => isIncome = true),
                    child: const Text('Income',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isIncome ? Colors.red : Colors.grey,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.zero,
                          bottomLeft: Radius.zero,
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: () => setState(() => isIncome = false),
                    child: const Text(
                      'Expense',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.account_balance_wallet),
                          title: Text(selectedWallet),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => WalletSelectionModal(
                                wallets: dummyWallets,
                                onSelected: (value) {
                                  setState(() => selectedWallet = value);
                                },
                              ),
                            );
                          },
                        ),
                        const Divider(height: 32),
                        Row(
                          children: [
                            const Icon(Icons.attach_money),
                            const SizedBox(width: 12),
                            Expanded(
                              child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  ThousandsSeparatorInputFormatter(),
                                ],
                                decoration: const InputDecoration(
                                  hintText: 'Masukkan jumlah',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 32),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.category),
                          title: Text(selectedCategory),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => CategorySelectionModal(
                                categories: dummyCategories,
                                onSelected: (value) {
                                  setState(() => selectedWallet = value);
                                },
                              ),
                            );
                          },
                        ),
                        const Divider(height: 32),
                        GestureDetector(
                          onTap: () async {
                            final result = await showModalBottomSheet<String>(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => NotesSectionModal(
                                initialNote: noteController.text,
                              ),
                            );
                            if (result != null) {
                              noteController.text = result;
                            }
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.message),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  noteController.text.isEmpty
                                      ? 'Catatan tambahan'
                                      : noteController.text,
                                  style: TextStyle(
                                    color: noteController.text.isEmpty
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 32),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.calendar_month),
                          title: const Text('Tanggal'),
                          subtitle: Text(
                              '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() => selectedDate = picked);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton.icon(
                    onPressed: () {
                      print('==== DATA TRANSAKSI ====');
                      print('Tipe: ${isIncome ? 'Income' : 'Expense'}');
                      print('Wallet: $selectedWallet');
                      print('Jumlah: ${amountController.text}');
                      print('Kategori: $selectedCategory');
                      print('Catatan: ${noteController.text}');
                      print('Tanggal: ${selectedDate.toIso8601String()}');
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text("Selanjutnya"),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddTransactionPageModal extends StatelessWidget {
  const AddTransactionPageModal({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      builder: (_, controller) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Scaffold(
            body: AddTransactionPage(),
          ),
        );
      },
    );
  }
}
