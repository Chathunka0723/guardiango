import 'package:flutter/material.dart';

class UnifiedPrivacyPolicyPage extends StatelessWidget {
  const UnifiedPrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      // Custom Transparent AppBar to sit on the blue background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC107),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. Navy Blue Header Section
            Container(
              width: double.infinity,
              color: const Color(0xFFFFC107), // Bright Yellow
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: const Icon(Icons.shield_outlined,
                        color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "We are committed to protecting your privacy and ensuring transparency about how we collect, use, and safeguard your personal information on our educational platform.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Last updated: March 17, 2026",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // 3. Detailed Sections
                  _buildContentSection(
                    icon: Icons.description_outlined,
                    title: "Introduction",
                    content:
                        "Welcome to GuardianGo! This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you visit our platform and use our services.\n\nBy accessing or using our platform, you agree to the collection and use of information in accordance with this policy. We are committed to protecting your privacy and ensuring your personal information is handled responsibly.",
                  ),

                  _buildContentSection(
                    icon: Icons.storage_outlined,
                    title: "Data Collection",
                    content:
                        "We collect information you provide directly to us, such as when you:\n\n"
                        "• Create an account or profile as a parent or driver\n"
                        "• Register students amd assign them to specific bus routes\n"
                        "• Make payments for transportation services or view transaction history\n"
                        "• Contact us for support, route inquiries, or safety concerns\n"
                        "• Provide feedback and ratings for drivers and trip experiences\n",
                  ),

                  // 3. Use of Data Section
                  _buildContentSection(
                    icon: Icons
                        .settings_outlined, // Matches the Gear icon in your grid
                    title: "Use of Data",
                    content: "We use the information we collect to:\n\n"
                        "• Provide, maintain, and improve our bus tracking and safety services.\n"
                        "• Process driver payments and track real-time route progress.\n"
                        "• Send you important updates about bus arrivals, delays, and account status.\n"
                        "• Respond to your comments, questions, and support requests.\n"
                        "• Analyze usage patterns to enhance app performance and user experience.\n"
                        "• Comply with legal obligations and protect the safety of students and users.",
                  ),

                  _buildContentSection(
                    icon: Icons.person_outline,
                    title: "Your Rights",
                    content:
                        "You have several rights regarding your personal information:\n\n"
                        "• Access: Request a copy of the personal information we hold about you.\n"
                        "• Correction: Ask us to correct any inaccurate information.\n"
                        "• Deletion: Request deletion of your personal information.",
                  ),

                  // 4. Contact Us Card
                  _buildContentSection(
                    icon: Icons.email_outlined,
                    title: "Contact Us",
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "If you have any questions about this Privacy Policy, please contact us at:",
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildContactRow(
                                  "Email:", "info.guardiango0@gmail.com"),
                              const SizedBox(height: 8),
                              _buildContactRow("Phone:", "+1 (555) 123-4567"),
                              const SizedBox(height: 8),
                              _buildContactRow("Hours:",
                                  "Monday - Friday, 9:00 AM - 6:00 PM"),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "We will respond to your inquiry as soon as possible and do our best to address any concerns you may have about your privacy and data security.",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.orange,
        mini: true,
        child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
      ),
    );
  }

  // Helper to build the white cards
  Widget _buildCardContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4)),
        ],
      ),
      child: child,
    );
  }

  // Helper for the grid items
  Widget _buildQuickLink(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text(label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF334155))),
      ],
    );
  }

  // Helper for the main content sections
  Widget _buildContentSection(
      {required IconData icon,
      required String title,
      String? content,
      Widget? child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orange, size: 24),
              const SizedBox(width: 12),
              Text(title,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0F172A))),
            ],
          ),
          const SizedBox(height: 16),
          if (content != null)
            Text(content,
                style: const TextStyle(
                    fontSize: 14, height: 1.6, color: Colors.black)),
          if (child != null) child,
        ],
      ),
    );
  }

  Widget _buildContactRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13, color: Color(0xFF475569)),
          children: [
            TextSpan(
                text: "$label ",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
