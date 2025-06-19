part of '../widgets.dart';

class PrivacyPolicyModal extends StatelessWidget {
  const PrivacyPolicyModal({super.key});

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
          style: const TextStyle(fontSize: 14, height: 1.5),
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
              'Privacy Policy for Catat Uangku',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const SelectableText(
              'Last updated: June 19, 2025\n\n'
              'Putra Taufik Syaharuddin ("we", "our", or "us") operates the Catat Uangku mobile application (the "Service"). '
              'This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our Service and the choices you have associated with that data.\n\n'
              'By using the Service, you agree to the collection and use of information in accordance with this policy.',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 24),
            _buildSection(
              'Information Collection and Use',
              'We collect different types of information to provide and improve our Service:\n\n'
                  '- Personal Information: name, email, phone number\n'
                  '- Device Information: model, OS, device ID, network\n'
                  '- Camera and Microphone: accessed for features that need it\n'
                  '- Files and Storage: access for saving or retrieving necessary data',
            ),
            _buildSection(
              'Use of Data',
              'We use collected data to:\n'
                  '- Provide and maintain our Service\n'
                  '- Notify you about changes\n'
                  '- Offer support\n'
                  '- Monitor and analyze usage\n'
                  '- Detect and fix issues',
            ),
            _buildSection(
              'Third-Party Services',
              'Our Service may link to or integrate with external services. We are not responsible for their privacy practices.\n\n'
                  'For payments, third-party processors handle your info. We don’t store payment data.',
            ),
            _buildSection(
              'Disclosure of Data',
              'We may disclose data:\n'
                  '- To comply with legal obligations\n'
                  '- To protect rights and safety\n'
                  '- To investigate misuse\n'
                  '- To prevent legal liabilities',
            ),
            _buildSection(
              'Data Retention',
              'We keep your data only as long as necessary to fulfill the purposes described in this policy.',
            ),
            _buildSection(
              'Security of Data',
              'We use reasonable efforts to secure your data, but no method is 100% safe.',
            ),
            _buildSection(
              'Children\'s Privacy',
              'Our Service is not for children under 13. We do not knowingly collect data from them. Contact us if you believe we have done so.',
            ),
            _buildSection(
              'GDPR Rights (for EEA residents)',
              'You have rights to:\n'
                  '- Access, correct, or delete your data\n'
                  '- Object or restrict processing\n'
                  '- Data portability\n'
                  '- Withdraw consent',
            ),
            _buildSection(
              'CCPA Rights (for California residents)',
              'You can request:\n'
                  '- What data we collect\n'
                  '- Deletion of your data\n'
                  '- That we do not sell your data (we don’t)',
            ),
            _buildSection(
              'Changes to This Policy',
              'We may update this policy. Changes take effect when posted. You are encouraged to review it regularly.',
            ),
            _buildSection(
              'Contact Us',
              'If you have any questions, contact:\nputrataufik0308@gmail.com',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
