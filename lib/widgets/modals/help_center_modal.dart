part of '../../pages/pages.dart';

class HelpCenterModal extends StatelessWidget {
  const HelpCenterModal({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        Text('Pusat Bantuan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 16),
        Text(
          'Jika Anda mengalami masalah atau memiliki pertanyaan, Anda dapat menghubungi tim dukungan kami melalui email support@catatuangku.com atau kunjungi halaman FAQ kami di situs resmi.',
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
