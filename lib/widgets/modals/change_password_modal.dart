part of '../../pages/pages.dart';

class ChangePasswordModal extends StatelessWidget {
  const ChangePasswordModal({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Ganti Kata Sandi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: oldPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Kata sandi lama',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: newPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Kata sandi baru',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: confirmPasswordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Konfirmasi kata sandi',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            // Validasi dan submit ganti password
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
            backgroundColor: Colors.blue,
          ),
          child: const Text('Simpan Perubahan'),
        ),
      ],
    );
  }
}
