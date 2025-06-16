part of '../widgets.dart';

class WalletTransactionHistory extends StatelessWidget {
  final String walletId;
  const WalletTransactionHistory({super.key, required this.walletId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteByWalletBloc, NoteByWalletState>(
      builder: (context, state) {
        if (state is NoteByWalletLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NoteByWalletLoaded) {
          final notes = state.notes;

          if (notes.isEmpty) {
            return const Center(
              child: Text('Tidak ada transaksi untuk dompet ini'),
            );
          }

          final groupedTransactions = <String, List<NoteModel>>{};
          for (var tx in notes) {
            final date = DateTime.tryParse(tx.date);
            if (date == null) continue;
            final dateStr = DateFormat('d MMMM', 'id_ID').format(date);
            groupedTransactions.putIfAbsent(dateStr, () => []).add(tx);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: groupedTransactions.entries.map((entry) {
              final date = entry.key;
              final txs = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Text(date,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                  ...txs.map((tx) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 6.0),
                        child: _buildTransactionTile(tx),
                      ))
                ],
              );
            }).toList(),
          );
        } else if (state is NoteByWalletError) {
          return Center(child: Text('Error: ${state.message}'));
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildTransactionTile(NoteModel tx) {
    IconData icon;
    Color iconColor;
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

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor.withOpacity(0.1),
          child: Icon(icon, color: iconColor),
        ),
        title: Text(tx.category,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: noteText.isNotEmpty ? Text(noteText) : null,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(amountText,
                style: TextStyle(
                    color: amountColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
            if (parsedDate != null)
              Text(DateFormat.Hm().format(parsedDate),
                  style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
