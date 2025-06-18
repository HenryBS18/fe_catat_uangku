part of '../widgets.dart';

class HeaderWalletWidget extends StatelessWidget {
  const HeaderWalletWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<WalletBloc, WalletState>(
          builder: (context, walletState) {
            final userName = userState is UserProfileLoaded
                ? userState.user.name ?? 'Pengguna'
                : 'Pengguna';

            final wallets =
                walletState is WalletLoaded ? walletState.wallets : [];

            return Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1E3C72), // deep blue
                    Color.fromARGB(255, 66, 117, 205), // soft royal blue
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hello,',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: wallets.length + 1,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          if (index == wallets.length) {
                            // Kartu tambah dompet (biarkan seperti sebelumnya)
                            return GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                  ),
                                  builder: (_) => const AddWalletModal(),
                                );
                              },
                              child: Container(
                                width: 150,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: CustomColors.primary,
                                        borderRadius:
                                            BorderRadius.circular(999),
                                      ),
                                      child: const Icon(Icons.add,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Tambahkan Dompet',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff565656),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          // 💡 Tambahkan GestureDetector di sini
                          final wallet = wallets[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      WalletDetailPage(walletId: wallet.id),
                                ),
                              );
                            },
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: CustomColors.primary,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Icon(Icons.wallet,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    wallet.name,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      NumberFormat.currency(
                                        locale: 'id_ID',
                                        symbol: 'Rp ',
                                        decimalDigits: 0,
                                      ).format(wallet.balance),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
