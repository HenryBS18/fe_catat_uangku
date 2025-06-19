part of './pages.dart';

class EditNotePage extends StatefulWidget {
  final NoteModel note;

  const EditNotePage({super.key, required this.note});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  bool isIncome = true;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  String selectedWallet = 'Tunai';
  String? selectedWalletId;
  String selectedCategory = 'Makanan & Minuman';
  DateTime selectedDate = DateTime.now();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    final note = widget.note;
    isIncome = note.type == 'income';
    amountController.text =
        ThousandsSeparatorInputFormatter.formatNumber(note.amount);
    noteController.text = note.note ?? '';
    selectedCategory = note.category;
    selectedDate = DateTime.tryParse(note.date) ?? DateTime.now();
    selectedWalletId = note.walletId;

    final walletState = context.read<WalletBloc>().state;
    if (walletState is WalletLoaded && walletState.wallets.isNotEmpty) {
      final wallet = walletState.wallets.firstWhere(
        (w) => w.id == selectedWalletId,
        orElse: () => walletState.wallets.first,
      );
      selectedWallet = wallet.name;
    }
  }

  void refreshBlocs() {
    context.read<TrendSaldoBloc>().add(LoadTrendSaldo());
    context.read<TopExpenseBloc>().add(LoadTopExpense());
    context.read<PlannedPaymentDashBloc>().add(LoadPlannedPayment());
    context.read<ArusKasBloc>().add(LoadArusKas());
    context.read<NoteBloc>().add(FetchNotes());
    context.read<WalletBloc>().add(FetchWallets());
  }

  void _updateNote() async {
    final parsedAmount =
        int.tryParse(amountController.text.replaceAll('.', ''));
    if (parsedAmount == null || parsedAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah tidak boleh kosong atau nol')),
      );
      return;
    }

    if (selectedWalletId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pilih dompet terlebih dahulu')),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final updatedNote = NoteModel(
        id: widget.note.id,
        walletId: selectedWalletId!,
        type: isIncome ? 'income' : 'expense',
        amount: parsedAmount,
        category: selectedCategory,
        date: selectedDate.toIso8601String(),
        note: noteController.text,
      );

      final success =
          await NoteService().updateNote(widget.note.id!, updatedNote);

      if (success) {
        refreshBlocs();
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Catatan berhasil diperbarui')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memperbarui catatan: $e')),
      );
    } finally {
      setState(() => isLoading = false);
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
        title: const Text('Edit Catatan',
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
                        // AMOUNT
                        Row(children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isIncome
                                  ? Colors.green.shade50
                                  : Colors.red.shade50,
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
                                  color: (isIncome ? Colors.green : Colors.red)
                                      .withOpacity(0.6),
                                ),
                              ),
                            ),
                          ),
                        ]),
                        const Divider(height: 32, thickness: 1),
                        // WALLET
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade50,
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
                              builder: (_) => BlocProvider.value(
                                value: context.read<WalletBloc>()
                                  ..add(FetchWallets()),
                                child: WalletSelectionModal(
                                  onSelected: (wallet) {
                                    setState(() {
                                      selectedWallet = wallet.name;
                                      selectedWalletId = wallet.id;
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                        const Divider(height: 32, thickness: 1),
                        // CATEGORY
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red.shade50,
                            ),
                            child: const Icon(
                              Icons.category_sharp,
                              color: Colors.redAccent,
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
                        const Divider(height: 32, thickness: 1),
                        // NOTES
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
                                ),
                                child: const Icon(
                                  Icons.notes,
                                  color: Color.fromARGB(255, 170, 157, 36),
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
                        const Divider(height: 32, thickness: 1),
                        // DATE
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.pink.shade50,
                            ),
                            child: const Icon(
                              Icons.date_range,
                              color: Colors.pink,
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _updateNote,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Simpan Perubahan',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
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
