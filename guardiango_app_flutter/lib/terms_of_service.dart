import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF00D933), // Using your Driver Green for contrast
        elevation: 0,
        title: const Text("Terms & Conditions",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              color: const Color(0xFF00D933),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: const Column(
                children: [
                  Icon(Icons.gavel_rounded, color: Colors.white, size: 50),
                  SizedBox(height: 16),
                  Text(
                    "Service Agreement",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Please read these terms carefully before using Guardiango.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildTermSection(
                    icon: Icons.verified_user_outlined,
                    title: "1. User Eligibility",
                    content:
                        "• Parents/Guardians must be legal representatives of the students.\n"
                        "• Drivers must possess a valid commercial license and undergo background checks.\n"
                        "• You agree to provide accurate and current information during registration.",
                  ),
                  _buildTermSection(
                    icon: Icons.location_on_outlined,
                    title: "2. Real-Time Tracking",
                    content:
                        "Guardiango provides GPS tracking for safety. However, we do not guarantee 100% accuracy due to potential signal interference, internet outages, or hardware limitations. Users should not rely solely on the app for emergency situations.",
                  ),
                  _buildTermSection(
                    icon: Icons.warning_amber_rounded,
                    title: "3. Driver Conduct",
                    content:
                        "Drivers strictly agree NOT to interact with the mobile application while the vehicle is in motion. The 'Start Trip' and 'End Trip' functions must only be used when the vehicle is safely parked.",
                  ),
                  _buildTermSection(
                    icon: Icons.notifications_active_outlined,
                    title: "4. Punctuality",
                    content:
                        "Parents are responsible for having students at the designated stop 5 minutes before the scheduled time. Drivers are not obligated to wait beyond the allotted time to ensure the safety and schedule of other students.",
                  ),
                  _buildTermSection(
                    icon: Icons.lock_outline,
                    title: "5. Account Termination",
                    content:
                        "We reserve the right to suspend or terminate accounts that violate safety protocols, provide false information, or misuse the communication features (Messages) to harass other users.",
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "By clicking 'Accept' or using the app, you agree to these terms.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTermSection(
      {required IconData icon,
      required String title,
      required String content}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
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
              Icon(icon, color: const Color(0xFF00D933), size: 24),
              const SizedBox(width: 12),
              Text(title,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
                fontSize: 14, height: 1.5, color: Color(0xFF334155)),
          ),
        ],
      ),
    );
  }
}
