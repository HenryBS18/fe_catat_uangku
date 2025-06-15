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

  void refresh(BuildContext context) {
    // Refresh Trend Saldo
    context.read<TrendSaldoBloc>().add(LoadTrendSaldo());

    // Refresh Top Expense
    context.read<TopExpenseBloc>().add(LoadTopExpense());

    // Refresh Planned Payment
    context.read<PlannedPaymentDashBloc>().add(LoadPlannedPayment());

    context.read<ArusKasBloc>().add(LoadArusKas());
    context.read<NoteBloc>().add(FetchNotes());
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
        // Kirim event ke semua bloc/widget terkait agar mereka update
        refresh(context);
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
                        Row(children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isIncome
                                  ? Colors.green.shade50
                                  : Colors
                                      .red.shade50, // latar belakang hijau muda
                            ),
                            child: Text(
                              'IDR',
                              style: TextStyle(
                                color: isIncome ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                                controller: amountController,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  ThousandsSeparatorInputFormatter(),
                                ],
                                style: TextStyle(
                                  color: isIncome ? Colors.green : Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                decoration: InputDecoration(
                                  hintText: '0',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color:
                                        (isIncome ? Colors.green : Colors.red)
                                            .withOpacity(0.6),
                                  ),
                                )),
                          ),
                        ]),
                        const Divider(
                            height: 32, thickness: 1, color: Colors.grey),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade50,
                              // Warna latar belakang ikon
                            ),
                            child: const Icon(
                              Icons.account_balance_wallet,
                              color: Color.fromARGB(255, 19, 145, 248),
                              size: 28,
                            ),
                          ),
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
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red.shade50,
                              // Warna latar belakang ikon
                            ),
                            child: const Icon(
                              Icons.category_sharp,
                              color: Colors.redAccent, // warna ikon
                              size: 28,
                            ),
                          ),
                          title: Text(selectedCategory),
                          trailing:
                              const Icon(Icons.arrow_forward_ios, size: 16),
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (_) => CategorySelectionModal(
                                onSelected: (value) {
                                  setState(() => selectedCategory = value);
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
                              setState(() {
                                noteController.text = result;
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.yellow.shade50,
                                  // Warna latar belakang ikon
                                ),
                                child: const Icon(
                                  Icons.notes,
                                  color: Color.fromARGB(
                                      255, 170, 157, 36), // warna ikon
                                  size: 28,
                                ),
                              ),
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
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.pink.shade50,
                              // Warna latar belakang ikon
                            ),
                            child: const Icon(
                              Icons.date_range,
                              color: Colors.pink, // warna ikon
                              size: 28,
                            ),
                          ),
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
