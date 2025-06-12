part of '../widgets.dart';

class CategorySelectionModal extends StatelessWidget {
  final Function(String) onSelected;

  CategorySelectionModal({super.key, required this.onSelected});

  final List<Map<String, dynamic>> categories = [
    {
      "name": "Makanan & Minuman",
      "description": "Pengeluaran untuk makan, minum, dan jajan.",
      "icon": Icons.fastfood
    },
    {
      "name": "Berbelanja",
      "description": "Belanja pakaian, barang kebutuhan pribadi, dll.",
      "icon": Icons.shopping_bag
    },
    {
      "name": "Perlengkapan rumah",
      "description": "Barang rumah tangga seperti sabun, alat dapur.",
      "icon": Icons.kitchen
    },
    {
      "name": "Perlengkapan sekolah",
      "description": "Alat tulis, buku, dan kebutuhan belajar.",
      "icon": Icons.school
    },
    {
      "name": "Transportasi",
      "description": "Ongkos kendaraan umum atau bahan bakar.",
      "icon": Icons.directions_bus
    },
    {
      "name": "Kendaraan",
      "description": "Servis, pajak, dan perawatan kendaraan.",
      "icon": Icons.directions_car
    },
    {
      "name": "Hidup dan Hiburan",
      "description": "Nonton, nongkrong, langganan hiburan.",
      "icon": Icons.movie
    },
    {
      "name": "Komunikasi, PC",
      "description": "Pulsa, internet, dan perangkat elektronik.",
      "icon": Icons.wifi
    },
    {
      "name": "Pengeluaran Finansial",
      "description": "Cicilan, donasi, pajak, asuransi.",
      "icon": Icons.account_balance_wallet
    },
    {
      "name": "Investasi",
      "description": "Tabungan, reksa dana, emas, crypto, dll.",
      "icon": Icons.trending_up
    },
    {
      "name": "Pemasukan",
      "description": "Gaji, bonus, hasil jualan, dll.",
      "icon": Icons.attach_money
    },
    {
      "name": "Lain-lain",
      "description": "Pengeluaran yang tidak termasuk kategori lain.",
      "icon": Icons.more_horiz
    },
  ];

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
              title: const Text("Pilih Kategori",
                  style: TextStyle(color: Colors.white)),
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: ListView.builder(
              controller: controller,
              itemCount: categories.length,
              itemBuilder: (_, index) {
                final category = categories[index];
                return ListTile(
                  leading: Icon(category['icon'], color: Colors.blue),
                  title: Text(category['name']),
                  subtitle: Text(category['description'],
                      style: const TextStyle(fontSize: 12)),
                  onTap: () {
                    onSelected(category['name']);
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
