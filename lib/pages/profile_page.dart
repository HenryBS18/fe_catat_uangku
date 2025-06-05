part of "pages.dart";

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;
  final String accountType;
  final String joinedDate;
  final int totalTransactions;

  const ProfilePage({
    super.key,
    this.name = 'Putra Taufik',
    this.email = 'putrataufik@gmail.com',
    this.accountType = 'Gratis',
    this.joinedDate = '12 Februari 2024',
    this.totalTransactions = 134,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 10,
            shadowColor: const Color.fromRGBO(0, 0, 0, 2), // replace deprecated withOpacity
            child: Column(
              children: [
                const SizedBox(height: 16),
                const CircleAvatar(
                  radius: 40,
                  // backgroundImage:
                  //     AssetImage('assets/profile.jpg'), // Ganti dengan assetmu
                ),
                const SizedBox(height: 8),
                Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(email),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(accountType, style: const TextStyle(color: Colors.grey)),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1E88E5), Color(0xFF00E676)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Dapatkan akses full dari Catat Uangku dengan Premium',
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightGreenAccent.shade100,
                              foregroundColor: Colors.blue.shade900,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {},
                            child: const Text('Tingkatkan Sekarang'),
                          ),
                          const Text(
                            'Rp. 99.000/bln',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Informasi Akun
          _sectionCard(
            context,
            title: 'Informasi Akun',
            children: [
              _itemTile(context, Icons.calendar_today, 'Tanggal Bergabung', joinedDate),
              _itemTile(context, Icons.account_circle, 'Tipe Akun', accountType),
              _itemTile(context, Icons.receipt, 'Jumlah Transaksi', '$totalTransactions transaksi dicatat'),
            ],
          ),

          const SizedBox(height: 16),

          // Fitur Akun
          _sectionCard(
            context,
            title: 'Fitur Akun',
            children: [
              _itemTile(context, Icons.lock, 'Ganti Kata Sandi'),
              _itemTile(context, Icons.notifications, 'Notifikasi & Pengingat'),
            ],
          ),

          const SizedBox(height: 16),

          // Lainnya
          _sectionCard(
            context,
            title: 'Lainnya',
            children: [
              _itemTile(context, Icons.help_outline, 'Pusat Bantuan'),
              _itemTile(context, Icons.description, 'Syarat & Ketentuan'),
              _itemTile(context, Icons.privacy_tip, 'Kebijakan Privasi'),
            ],
          ),

          const SizedBox(height: 24),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: () {
              //
            },
            child: const Text('Keluar dari Akun', style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // Helper Widget untuk Section
  Widget _sectionCard(BuildContext context, {required String title, required List<Widget> children}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      shadowColor: const Color.fromRGBO(0, 0, 0, 2), // avoid deprecated withOpacity
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  // Item List Tile
  Widget _itemTile(BuildContext context, IconData icon, String title, [String? trailing]) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing != null ? Text(trailing) : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: title == 'Jumlah Transaksi'
          ? () {
              Navigator.pushNamed(context, '/payment-planning-page'); // nanti bisa diganti
            }
          : trailing == null
              ? () => _openModal(context, title)
              : null, // semua item lain dengan trailing = tidak bisa diklik
    );
  }

  // Modal untuk fitur akun
  void _openModal(BuildContext context, String title) {
    Widget content;

    switch (title) {
      case 'Ganti Kata Sandi':
        content = const ChangePasswordModal();
        break;
      case 'Notifikasi & Pengingat':
        content = const NotificationSettingModal();
        break;
      case 'Pusat Bantuan':
        content = const HelpCenterModal();
        break;
      case 'Syarat & Ketentuan':
        content = const TermsAndConditionsModal();
        break;
      case 'Kebijakan Privasi':
        content = const PrivacyPolicyModal();
        break;
      default:
        content = Center(child: Text('Konten tidak tersedia untuk $title'));
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        builder: (_, controller) => Scaffold(
          appBar: AppBar(
            title: Text(title),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0.5,
          ),
          body: content,
        ),
      ),
    );
  }
}
