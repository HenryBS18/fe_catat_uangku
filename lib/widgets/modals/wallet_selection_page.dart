part of '../widgets.dart';

class WalletSelectionModal extends StatelessWidget {
  final Function(WalletModel) onSelected;

  const WalletSelectionModal({
    super.key,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.95,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF0F55C3),
              centerTitle: true,
              title: const Text("Pilih Dompet",
                  style: TextStyle(color: Colors.white)),
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: BlocBuilder<WalletBloc, WalletState>(
              builder: (context, state) {
                if (state is WalletLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is WalletLoaded) {
                  return ListView.builder(
                    controller: controller,
                    itemCount: state.wallets.length,
                    itemBuilder: (_, index) {
                      final wallet = state.wallets[index];
                      return ListTile(
                        title: Text(wallet.name),
                        subtitle: Text('Saldo: Rp${wallet.balance}'),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          onSelected(wallet);
                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                } else if (state is WalletError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }
}
