part of 'pages.dart';

class WalletDetailPage extends StatelessWidget {
  final String walletId;

  const WalletDetailPage({super.key, required this.walletId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              WalletTrendBloc(WalletService())..add(FetchWalletTrend(walletId)),
        ),
        BlocProvider(
          create: (_) => NoteByWalletBloc(NoteService())
            ..add(FetchNotesByWallet(walletId)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Wallet'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                await showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  builder: (_) => BlocProvider.value(
                    value: context.read<WalletBloc>(),
                    child: EditWalletModal(
                      walletId: walletId,
                      onClosed: () {
                        context.read<WalletBloc>().add(FetchWallets());
                        context
                            .read<WalletTrendBloc>()
                            .add(FetchWalletTrend(walletId));
                        context
                            .read<NoteByWalletBloc>()
                            .add(FetchNotesByWallet(walletId));
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<WalletTrendBloc, WalletTrendState>(
            builder: (context, state) {
              if (state is WalletTrendLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WalletTrendError) {
                return Center(
                    child: Text('Gagal memuat data\n${state.message}'));
              } else if (state is WalletTrendLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('30 HARI TERAKHIR',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500)),
                      Text(
                        NumberFormat.currency(
                                locale: 'id_ID',
                                symbol: 'IDR ',
                                decimalDigits: 2)
                            .format(state.currentBalance),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const WalletTrendChart(),
                      const SizedBox(height: 24),
                      const Text('Riwayat Transaksi',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      WalletTransactionHistory(walletId: walletId),
                    ],
                  ),
                );
              }
              return const SizedBox(); // Untuk state awal
            },
          ),
        ),
      ),
    );
  }
}
