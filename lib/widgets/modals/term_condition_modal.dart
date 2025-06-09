part of '../widgets.dart';

class TermsAndConditionsModal extends StatelessWidget {
  const TermsAndConditionsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('Syarat & Ketentuan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Text(
          'Dengan menggunakan aplikasi Catat Uangku, Anda setuju untuk mematuhi seluruh syarat dan ketentuan yang berlaku, termasuk kebijakan privasi dan ketentuan penggunaan layanan.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
