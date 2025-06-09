part of '../widgets.dart';

class AddNotePage extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  const AddNotePage({super.key, this.initialData});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  bool isIncome = true;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String? noteError;

  String selectedWallet = 'Tunai';
  String? selectedWalletId;
  String selectedCategory = 'Makanan & Minuman';
  DateTime selectedDate = DateTime.now();

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

    final data = widget.initialData;
    if (data != null) {
      final amount = data['amount'];
      if (amount != null) {
        amountController.text =
            ThousandsSeparatorInputFormatter.formatNumber(amount);
      }
      noteController.text = data['note'] ?? '';
      selectedCategory = data['category'] ?? selectedCategory;
      selectedDate = DateTime.tryParse(data['date'] ?? '') ?? DateTime.now();

      // Set type (income/expense)
      final type = data['type']?.toLowerCase();
      if (type == 'income') {
        isIncome = true;
      } else if (type == 'expense') {
        isIncome = false;
      }
    }
    final state = context.read<WalletBloc>().state;
    if (state is WalletLoaded && state.wallets.isNotEmpty) {
      final sorted = [...state.wallets]
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt)); // ⬅️ perbaikan
      final oldestWallet = sorted.first;

      selectedWallet = oldestWallet.name;
      selectedWalletId = oldestWallet.id;
    }
  }

  bool isLoading = false;

  void _saveNote() async {
    if (amountController.text.isEmpty ||
        int.tryParse(amountController.text.replaceAll('.', '')) == null ||
        int.parse(amountController.text.replaceAll('.', '')) <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah tidak boleh kosong atau nol')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final NoteService noteService = NoteService();
      if (selectedWalletId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pilih dompet terlebih dahulu')),
        );
        return;
      }
      final note = NoteModel(
        walletId: selectedWalletId!, // Hard Code sementara
        type: isIncome ? 'income' : 'expense',
        amount: int.parse(amountController.text.replaceAll('.', '')),
        category: selectedCategory,
        date: selectedDate.toIso8601String(),
        note: noteController.text,
      );

      final bool isSuccess = await noteService.createNote(note);

      if (isSuccess) {
        Navigator.pop(context); // close modal/page
        CustomSnackbar.showSuccess(context, "Transaksi berhasil di simpan");
        return;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan transaksi: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
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
                              builder: (_) {
                                return BlocProvider.value(
                                  value: context.read<WalletBloc>()
                                    ..add(FetchWallets()),
                                  child: WalletSelectionModal(
                                    onSelected: (wallet) {
                                      setState(() {
                                        selectedWallet = wallet.name;
                                        selectedWalletId =
                                            wallet.id; // <- tambahkan ini
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const Divider(
                            height: 32, thickness: 1, color: Colors.grey),
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
                        const Divider(
                            height: 32, thickness: 1, color: Colors.grey),
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
                        const Divider(
                            height: 32, thickness: 1, color: Colors.grey),
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
                        const Divider(
                            height: 32, thickness: 1, color: Colors.grey),
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
                    onPressed: isLoading ? null : _saveNote,
                    icon: isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.arrow_forward),
                    label: Text(isLoading ? 'Menyimpan...' : 'Selanjutnya'),
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

class AddNotePageModal extends StatelessWidget {
  final Map<String, dynamic>? initialData;

  const AddNotePageModal({super.key, this.initialData});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (_, __) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Scaffold(
            body: AddNotePage(initialData: initialData), // ⬅️ disisipkan
          ),
        );
      },
    );
  }
}
