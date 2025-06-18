part of '../widgets.dart';

class EditWalletModal extends StatefulWidget {
  final String walletId;
  final VoidCallback? onClosed;
  const EditWalletModal({super.key, required this.walletId, this.onClosed});

  @override
  State<EditWalletModal> createState() => _EditWalletModalState();
}

class _EditWalletModalState extends State<EditWalletModal> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final rawText = _balanceController.text.trim().replaceAll('.', '');
      final parsedBalance = int.tryParse(rawText) ?? 0;

      if (parsedBalance > 1000000000000) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Saldo tidak boleh lebih dari 1 triliun')),
        );
        return;
      }

      final updatedWallet = WalletModel(
        id: widget.walletId,
        name: _nameController.text.trim(),
        balance: parsedBalance,
        createdAt: DateTime.now(),
      );

      await WalletService().updateWallet(updatedWallet);
      refresh(context);
      context.read<WalletBloc>().add(FetchWallets());
      if (mounted) Navigator.pop(context);
    }
  }

  void _delete() async {
    await WalletService().deleteWallet(widget.walletId);
    refresh(context);
    context.read<WalletBloc>().add(FetchWallets());
    if (mounted) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(FetchWalletById(widget.walletId));
  }

  @override
  void dispose() {
    widget.onClosed?.call();
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 0.95;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (_, controller) => BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoading) {
            return const Padding(
              padding: EdgeInsets.all(24),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (state is WalletByIdLoaded) {
            if (_nameController.text.isEmpty &&
                _balanceController.text.isEmpty) {
              _nameController.text = state.wallet.name;
              _balanceController.text =
                  ThousandsSeparatorInputFormatter.formatNumber(
                state.wallet.balance,
              );
            }

            return Container(
              height: height,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  controller: controller,
                  children: [
                    const Text(
                      'Edit Dompet',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Nama Dompet',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        prefixIcon: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade50,
                          ),
                          child: const Icon(
                            Icons.account_balance_wallet,
                            color: Color.fromARGB(255, 19, 145, 248),
                            size: 24,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.zero,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _balanceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        ThousandsSeparatorInputFormatter(),
                      ],
                      decoration: InputDecoration(
                        labelText: 'Saldo (Rp)',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        prefixIcon: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade50,
                          ),
                          child: const Icon(
                            Icons.attach_money,
                            color: Color.fromARGB(255, 19, 145, 248),
                            size: 24,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.zero,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _delete,
                            icon: const Icon(Icons.delete, color: Colors.red),
                            label: const Text('Hapus',
                                style: TextStyle(color: Colors.red)),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _save,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CustomColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Text('Simpan',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is WalletError) {
            return Center(child: Text('Error: ${state.message}'));
          }

          return const SizedBox();
        },
      ),
    );
  }

  void refresh(BuildContext context) {
    context.read<TrendSaldoBloc>().add(LoadTrendSaldo());
    context.read<TopExpenseBloc>().add(LoadTopExpense());
    context.read<PlannedPaymentDashBloc>().add(LoadPlannedPayment());
    context.read<ArusKasBloc>().add(LoadArusKas());
    context.read<NoteBloc>().add(FetchNotes());
  }
}
