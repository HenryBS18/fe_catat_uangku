part of 'pages.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  Map<String, String> _walletNames = {};

  @override
  void initState() {
    super.initState();

    final noteState = context.read<NoteBloc>().state;
    if (noteState is! NoteLoaded) {
      context.read<NoteBloc>().add(FetchNotes());
    }

    final walletState = context.read<WalletBloc>().state;
    if (walletState is! WalletLoaded) {
      context.read<WalletBloc>().add(FetchWallets());
    }
  }

  void _extractWalletNames(List<WalletModel> wallets) {
    setState(() {
      _walletNames = {for (var w in wallets) w.id: w.name};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Catatan',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, walletState) {
          if (walletState is WalletLoaded && _walletNames.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _extractWalletNames(walletState.wallets);
            });
          }

          return BlocBuilder<NoteBloc, NoteState>(
            builder: (context, state) {
              if (state is NoteLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NoteLoaded) {
                final transactions = state.notes;

                if (transactions.isEmpty) {
                  return const Center(child: Text('Tidak ada transaksi'));
                }

                final groupedTransactions = <String, List<NoteModel>>{};

                for (var tx in transactions) {
                  final date = DateTime.tryParse(tx.date);
                  if (date == null) continue;
                  final dateStr = DateFormat('d MMMM', 'id_ID').format(date);
                  groupedTransactions.putIfAbsent(dateStr, () => []).add(tx);
                }

                return ListView(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  children: groupedTransactions.entries.map((entry) {
                    final date = entry.key;
                    final txs = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12.0, horizontal: 16.0),
                          child: Text(
                            date,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        ...txs.asMap().entries.map((entry) {
                          final i = entry.key;
                          final tx = entry.value;
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: _buildTransactionTile(tx),
                              ),
                              if (i == txs.length - 1) ...[
                                const SizedBox(height: 12),
                                const Divider(
                                  thickness: 8,
                                  color: Color.fromARGB(255, 224, 224, 224),
                                ),
                              ],
                            ],
                          );
                        }),
                      ],
                    );
                  }).toList(),
                );
              } else if (state is NoteError) {
                return Center(
                    child: Text('Terjadi kesalahan: ${state.message}'));
              }

              return const SizedBox();
            },
          );
        },
      ),
    );
  }

  Widget _buildTransactionTile(NoteModel tx) {
    IconData icon;
    Color iconColor;
    String walletName = _walletNames[tx.walletId] ?? 'Dompet Tidak Diketahui';
    String noteText = (tx.note?.isNotEmpty ?? false)
        ? (tx.note!.length > 20 ? tx.note!.substring(0, 20) + '...' : tx.note!)
        : '';

    switch (tx.category) {
      case 'Makanan & Minuman':
        icon = Icons.fastfood;
        iconColor = Colors.redAccent;
        break;
      case 'Berbelanja':
        icon = Icons.shopping_bag;
        iconColor = Colors.deepOrange;
        break;
      case 'Perlengkapan rumah':
        icon = Icons.kitchen;
        iconColor = Colors.brown;
        break;
      case 'Perlengkapan sekolah':
        icon = Icons.school;
        iconColor = Colors.indigo;
        break;
      case 'Transportasi':
        icon = Icons.directions_bus;
        iconColor = Colors.blue;
        break;
      case 'Kendaraan':
        icon = Icons.directions_car;
        iconColor = Colors.teal;
        break;
      case 'Hidup dan Hiburan':
        icon = Icons.movie;
        iconColor = Colors.purple;
        break;
      case 'Komunikasi, PC':
        icon = Icons.wifi;
        iconColor = Colors.cyan;
        break;
      case 'Pengeluaran Finansial':
        icon = Icons.account_balance_wallet;
        iconColor = Colors.green;
        break;
      case 'Investasi':
        icon = Icons.trending_up;
        iconColor = Colors.lightGreen;
        break;
      case 'Pemasukan':
        icon = Icons.attach_money;
        iconColor = Colors.greenAccent;
        break;
      case 'Lain-lain':
        icon = Icons.more_horiz;
        iconColor = Colors.grey;
        break;
      default:
        icon = Icons.notes;
        iconColor = Colors.grey;
    }

    final amountText = (tx.type == 'expense' ? '-Rp' : 'Rp') +
        NumberFormat("#,##0", "id_ID").format(tx.amount);

    final amountColor = tx.type == 'expense'
        ? Colors.red
        : (tx.type == 'income' ? Colors.green : Colors.black);

    final parsedDate = DateTime.tryParse(tx.date);

    return ListTile(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => EditNotePageModal(note: tx),
        );
      },
      leading: CircleAvatar(
        backgroundColor: iconColor.withOpacity(0.1),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        tx.category,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(walletName),
          if (noteText.isNotEmpty)
            Text(
              noteText,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            amountText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: amountColor,
            ),
          ),
          if (parsedDate != null)
            Text(
              DateFormat.Hm().format(parsedDate),
              style: const TextStyle(fontSize: 12),
            ),
        ],
      ),
    );
  }
}
