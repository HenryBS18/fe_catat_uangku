part of '../widgets.dart';

class PrivacyPolicyModal extends StatelessWidget {
  const PrivacyPolicyModal({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('Kebijakan Privasi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Text(
          'Kami menghargai privasi Anda. Data yang dikumpulkan akan digunakan hanya untuk meningkatkan layanan kami dan tidak akan dibagikan tanpa izin Anda.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
