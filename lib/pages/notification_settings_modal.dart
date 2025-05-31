part of 'pages.dart';

class NotificationSettingModal extends StatefulWidget {
  const NotificationSettingModal({super.key});

  @override
  State<NotificationSettingModal> createState() =>
      _NotificationSettingModalState();
}

class _NotificationSettingModalState extends State<NotificationSettingModal> {
  bool isDailyReminderEnabled = true;
  bool isBudgetWarningEnabled = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Notifikasi & Pengingat',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        SwitchListTile(
          title: const Text('Pengingat harian untuk mencatat pengeluaran'),
          value: isDailyReminderEnabled,
          onChanged: (value) {
            setState(() {
              isDailyReminderEnabled = value;
            });
          },
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('Peringatan saat anggaran hampir habis'),
          value: isBudgetWarningEnabled,
          onChanged: (value) {
            setState(() {
              isBudgetWarningEnabled = value;
            });
          },
        ),
      ],
    );
  }
}
