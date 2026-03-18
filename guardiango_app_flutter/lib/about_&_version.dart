import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/privacy_policy.dart';
import 'package:guardiango_app_flutter/terms_of_service.dart';

class AboutVersionPage extends StatelessWidget {
  const AboutVersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'About & Version',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            // App Logo Section
            Center(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/bus_logo.png',
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.directions_bus,
                                  size: 50, color: Color(0xFF00D933)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Guardiango',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const Text(
                    'Your Safety, Our Priority',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Version Info Section
            _buildSection(
              children: [
                _buildInfoRow('Version', '1.0.0 (Build 102)'),
                const Divider(),
                _buildInfoRow('Release Date', 'March 23, 2026'),
                const Divider(),
                _buildInfoRow('Environment', 'Production'),
              ],
            ),

            // Links Section
            _buildSection(
              children: [
                _buildClickableRow(
                  context,
                  'Privacy Policy',
                  Icons.privacy_tip_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UnifiedPrivacyPolicyPage(),
                      ),
                    );
                  },
                ),
                const Divider(),
                _buildClickableRow(
                  context,
                  'Terms of Service',
                  Icons.description_outlined,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TermsAndConditionsPage(),
                      ),
                    );
                  },
                ),
                const Divider(),
                _buildClickableRow(
                    context, 'Open Source Licenses', Icons.code_rounded),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              '© 2025 Guardiango Inc. All rights reserved.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({required List<Widget> children}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEEEEEE)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          Text(value, style: const TextStyle(color: Colors.grey, fontSize: 15)),
        ],
      ),
    );
  }

  Widget _buildClickableRow(BuildContext context, String title, IconData icon,
      {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.blueGrey),
            const SizedBox(width: 12),
            Text(title,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            const Spacer(),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
