part of '../../pages/pages.dart';

class WalletSelectionModal extends StatelessWidget {
  final List<String> wallets;
  final Function(String) onSelected;

  const WalletSelectionModal({
    super.key,
    required this.wallets,
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
            backgroundColor: const Color(0xFFF7F7F7),
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
            body: ListView.builder(
              controller: controller,
              itemCount: wallets.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(wallets[index]),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    onSelected(wallets[index]);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
