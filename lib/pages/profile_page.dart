part of "pages.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleLogout(BuildContext context) async {
    final userService = UserService();
    try {
      final loggedOut = await userService.logout();
      if (!context.mounted) return;

      if (loggedOut) {
        await Restart.restartApp();
        return;
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal keluar akun: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserState>(
      builder: (context, state) {
        if (state is UserProfileLoading || state is UserInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is UserProfileLoaded) {
          final user = state.user;
          return RefreshIndicator(
            onRefresh: () async {
              context.read<UserProfileBloc>().add(FetchUserProfile());
            },
            child: _buildProfile(context, user),
          );
        } else if (state is UserProfileError) {
          return Scaffold(
            body: Center(child: Text('❌ ${state.message}')),
          );
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildProfile(BuildContext context, User user) {
    final accountType = user.isPremium == true ? 'Premium' : 'Gratis';
    final joinedDate = user.createdAt != null
        ? DateFormat('d MMMM yyyy', 'id_ID').format(user.createdAt!)
        : '-';

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Profil',
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeader(user.name ?? '-', user.email, accountType),
            const SizedBox(height: 16),
            _buildSection('Informasi Akun', [
              _itemTile(context, Icons.calendar_today, 'Tanggal Bergabung',
                  joinedDate),
              _itemTile(
                  context, Icons.account_circle, 'Tipe Akun', accountType),
            ]),
            const SizedBox(height: 16),
            _buildSection('Fitur Akun', [
              _itemTile(context, Icons.lock, 'Ganti Kata Sandi'),
              _itemTile(context, Icons.notifications, 'Notifikasi & Pengingat'),
            ]),
            const SizedBox(height: 16),
            _buildSection('Lainnya', [
              _itemTile(context, Icons.help_outline, 'Pusat Bantuan'),
              _itemTile(context, Icons.description, 'Syarat & Ketentuan'),
              _itemTile(context, Icons.privacy_tip, 'Kebijakan Privasi'),
            ]),
            const SizedBox(height: 24),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String name, String email, String accountType) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      shadowColor: const Color.fromRGBO(0, 0, 0, 2),
      child: Column(
        children: [
          const SizedBox(height: 28),
          Text(name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(email),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child:
                Text(accountType, style: const TextStyle(color: Colors.grey)),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        // TODO: panggil halaman pembayaran / logika upgrade
                        debugPrint('Tombol Tingkatkan Sekarang ditekan');
                      },
                      child: const Text('Tingkatkan Sekarang'),
                    ),
                    const Text(
                      'Rp. 99.000/bln',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 10,
      shadowColor: const Color.fromRGBO(0, 0, 0, 2),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _itemTile(BuildContext context, IconData icon, String title,
      [String? trailing]) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: trailing != null
          ? Text(trailing)
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: trailing == null
          ? () => _openModal(context, title)
          : title == 'Jumlah Transaksi'
              ? () => Navigator.pushNamed(context, '/payment-planning-page')
              : null,
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      onPressed: () => _handleLogout(context),
      child: const Text('Keluar dari Akun',
          style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }

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
