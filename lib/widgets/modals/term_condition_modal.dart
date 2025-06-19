part of '../widgets.dart';

class TermsAndConditionsModal extends StatelessWidget {
  const TermsAndConditionsModal({super.key});

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SelectableText(
          content,
          style: const TextStyle(fontSize: 14, height: 1.6),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Syarat dan Ketentuan Penggunaan Aplikasi Catat Uangku',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildSection(
              '1. Persetujuan Pengguna',
              'Dengan mengunduh, mengakses, atau menggunakan aplikasi Catat Uangku (“Aplikasi”), Anda menyatakan telah membaca, memahami, dan menyetujui seluruh syarat dan ketentuan ini. '
                  'Jika Anda tidak menyetujui salah satu bagian dari Syarat dan Ketentuan ini, mohon untuk tidak menggunakan Aplikasi ini.',
            ),
            _buildSection(
              '2. Deskripsi Layanan',
              'Catat Uangku adalah aplikasi pencatatan keuangan pribadi yang memungkinkan pengguna mencatat pemasukan, pengeluaran, membuat anggaran, merencanakan pembayaran, serta menggunakan fitur lanjutan seperti scan nota dan input suara.',
            ),
            _buildSection(
              '3. Hak Milik Intelektual',
              'Seluruh hak kekayaan intelektual yang terdapat dalam Aplikasi ini, termasuk namun tidak terbatas pada kode sumber, desain, logo, dan konten, adalah milik Putra Taufik Syaharuddin dan dilindungi oleh hukum yang berlaku. '
                  'Pengguna tidak diperkenankan menyalin, mendistribusikan, memodifikasi, atau menggunakan bagian manapun dari Aplikasi tanpa izin tertulis.',
            ),
            _buildSection(
              '4. Penggunaan Aplikasi',
              'Anda setuju untuk menggunakan Aplikasi secara wajar dan tidak melanggar hukum yang berlaku. Anda dilarang menggunakan Aplikasi untuk:\n'
                  '- Aktivitas ilegal atau melanggar hukum\n'
                  '- Meretas atau mencoba mengakses data pengguna lain\n'
                  '- Menyebarkan malware atau program berbahaya lainnya\n'
                  '- Menyalahgunakan fitur seperti OCR, voice input, dan budget planner',
            ),
            _buildSection(
              '5. Akses Fitur Perangkat',
              'Aplikasi dapat meminta izin untuk mengakses fitur perangkat seperti kamera, mikrofon, dan penyimpanan untuk mendukung fungsi scan nota dan input suara. '
                  'Data yang diakses hanya digunakan untuk keperluan internal aplikasi dan tidak dibagikan tanpa persetujuan pengguna. Detail dapat ditemukan pada Kebijakan Privasi.',
            ),
            _buildSection(
              '6. Fitur Berbayar dan Langganan',
              'Beberapa fitur Aplikasi, seperti Scan Nota, dapat diakses melalui langganan premium. Pembayaran dilakukan melalui penyedia pihak ketiga (seperti Midtrans). '
                  'Kami tidak menyimpan informasi kartu pembayaran Anda. Kebijakan pembatalan dan pengembalian dana mengikuti ketentuan penyedia layanan pembayaran tersebut.',
            ),
            _buildSection(
              '7. Tanggung Jawab Pengguna',
              'Pengguna bertanggung jawab atas keamanan akun dan data yang dicatat dalam Aplikasi. Kami tidak bertanggung jawab atas kerugian yang diakibatkan oleh kesalahan input data, kehilangan perangkat, atau penggunaan yang tidak sah oleh pihak ketiga.',
            ),
            _buildSection(
              '8. Pembaruan Aplikasi',
              'Kami dapat melakukan pembaruan Aplikasi secara berkala untuk menambahkan fitur, memperbaiki bug, atau memperbarui kebijakan. Anda disarankan untuk selalu menggunakan versi terbaru untuk mendapatkan performa terbaik.',
            ),
            _buildSection(
              '9. Pemutusan Akses',
              'Kami berhak membatasi atau mengakhiri akses pengguna terhadap Aplikasi jika ditemukan pelanggaran terhadap Syarat dan Ketentuan, penyalahgunaan fitur, atau aktivitas ilegal lainnya tanpa pemberitahuan sebelumnya.',
            ),
            _buildSection(
              '10. Batasan Tanggung Jawab',
              'Kami tidak menjamin bahwa Aplikasi akan selalu tersedia atau bebas dari gangguan. Dalam keadaan apapun, Putra Taufik Syaharuddin tidak bertanggung jawab atas kerugian tidak langsung, insidental, atau konsekuensial yang timbul dari penggunaan Aplikasi.',
            ),
            _buildSection(
              '11. Perubahan Syarat dan Ketentuan',
              'Syarat dan Ketentuan ini dapat diperbarui dari waktu ke waktu. Perubahan akan diumumkan di dalam Aplikasi dan berlaku efektif segera setelah dipublikasikan. '
                  'Dengan tetap menggunakan Aplikasi setelah perubahan tersebut, Anda dianggap menyetujui Syarat dan Ketentuan yang baru.',
            ),
            _buildSection(
              '12. Hukum yang Berlaku',
              'Syarat dan Ketentuan ini diatur oleh dan ditafsirkan sesuai dengan hukum yang berlaku di Republik Indonesia. '
                  'Segala sengketa yang timbul dari penggunaan Aplikasi akan diselesaikan secara musyawarah atau melalui mekanisme hukum di wilayah hukum pengembang.',
            ),
            _buildSection(
              '13. Kontak Kami',
              'Jika Anda memiliki pertanyaan, saran, atau keluhan terkait Syarat dan Ketentuan ini, Anda dapat menghubungi kami melalui:\n\n'
                  'Email: putrataufik0308@gmail.com',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
