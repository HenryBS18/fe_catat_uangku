part of 'pages.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  int currentIndex = 1;
  List<dynamic> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

   Future<void> fetchTransactions() async {
    try {
      final data = await apiServices.getApiResponse('/api/transactions');
      setState(() {
        transactions =
            data.map((json) => Transaction.fromJson(json)).toList();
      });
    } catch (e) {
      print('Error fetching transactions: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : transactions.isEmpty
              ? const Center(child: Text('Tidak ada transaksi'))
              : ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    return ListTile(
                      leading: Icon(
                        tx['type'] == 'expense' ? Icons.arrow_upward : Icons.arrow_downward,
                        color: tx['type'] == 'expense' ? Colors.red : Colors.green,
                      ),
                      title: Text(tx['category'] ?? 'Tanpa kategori'),
                      subtitle: Text(tx['note'] ?? ''),
                      trailing: Text(
                        'Rp ${tx['amount']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });

          // Navigasi ke halaman lain
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/transaction-history');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 0 ? Icons.home : Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 1 ? Icons.timer : Icons.timer_outlined),
            label: 'Rencana',
          ),
          BottomNavigationBarItem(
            icon: Icon(currentIndex == 2 ? Icons.person : Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
