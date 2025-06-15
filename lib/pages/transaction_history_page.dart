part of 'pages.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  int currentIndex = 1; // Riwayat ada di tengah (index ke-1)

  @override
  void initState() {
    super.initState();
    context.read<NoteBloc>().add(FetchNotes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: BlocBuilder<NoteBloc, NoteState>(
        builder: (context, state) {
          if (state is NoteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoteLoaded) {
            final transactions = state.notes;

            if (transactions.isEmpty) {
              return const Center(child: Text('Tidak ada transaksi'));
            }

            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final tx = transactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Card(
                    child: ListTile(
                      leading: Icon(
                        tx.type == 'expense' ? Icons.arrow_upward : Icons.arrow_downward,
                        color: tx.type == 'expense' ? Colors.red : Colors.green,
                      ),
                      title: Text(tx.category ?? 'Tanpa kategori'),
                      subtitle: Text(tx.note ?? ''),
                      trailing: Text(
                        'Rp ${tx.amount}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is NoteError) {
            return Center(child: Text('Terjadi kesalahan: ${state.message}'));
          }

          return const SizedBox();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/main-page');
          } else if (index == 1) {
            // Halaman saat ini (Riwayat)
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile-page');
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PlanningPage()),
          );
        },
        tooltip: 'Rencana',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
