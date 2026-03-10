import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;
  bool isAutoLock = true;
  bool isBiometric = false;
  bool isCrashReporting = true;
  String selectedFontSize = 'Medium';
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("App Settings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text("Customize your app experience",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Appearance Section ---
            _buildSectionContainer(
              title: "Appearance",
              children: [
                _buildSwitchTile(
                  "Dark Mode",
                  "Use dark theme for better night viewing",
                  isDarkMode,
                  (val) => setState(() => isDarkMode = val),
                  icon: isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
                const SizedBox(height: 15),
                _buildDropdownTile("Font Size", ["Small", "Medium", "Large"],
                    selectedFontSize, (val) => setState(() => selectedFontSize = val!)),
              ],
            ),

            const SizedBox(height: 16),

            // --- Security & Privacy Section ---
            _buildSectionContainer(
              title: "Security & Privacy",
              icon: Icons.shield_outlined,
              iconColor: Colors.green,
              children: [
                _buildSwitchTile(
                  "Auto Lock",
                  "Lock App when inactive",
                  isAutoLock,
                  (val) => setState(() => isAutoLock = val),
                ),
                _buildSwitchTile(
                  "Biometric Authentication",
                  "Use fingerprint or face ID",
                  isBiometric,
                  (val) => setState(() => isBiometric = val),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --- General Section ---
            _buildSectionContainer(
              title: "General",
              children: [
                _buildDropdownTile("Language", ["English", "Sinhala", "Tamil"],
                    selectedLanguage, (val) => setState(() => selectedLanguage = val!)),
                _buildSwitchTile(
                  "Crash Reporting",
                  "Help improve the app",
                  isCrashReporting,
                  (val) => setState(() => isCrashReporting = val),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --- Support Links ---
            _buildSimpleTile(Icons.help_outline, "Send feedback"),
            _buildSimpleTile(Icons.verified_user_outlined, "Privacy Policy"),
            _buildSimpleTile(Icons.info_outline, "About & Version"),

            const SizedBox(height: 24),

            // --- Account Actions (Red Section) ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.red.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Account Actions",
                      style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildActionButton(Icons.download, "Export My Data", Colors.white, Colors.black),
                  const SizedBox(height: 12),
                  _buildActionButton(Icons.logout, "Log Out", Colors.red, Colors.white),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text("School Bus Tracker v1.0.0",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Helper UI Methods ---

  Widget _buildSectionContainer({required String title, IconData? icon, Color? iconColor, required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) Icon(icon, color: iconColor, size: 20),
              if (icon != null) const SizedBox(width: 8),
              Text(title, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String subtitle, bool value, Function(bool) onChanged, {IconData? icon}) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      secondary: icon != null ? Icon(icon, size: 20) : null,
      value: value,
      activeThumbColor: Colors.black,
      onChanged: onChanged,
    );
  }

  Widget _buildDropdownTile(String label, List<String> options, String currentValue, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: currentValue,
              items: options.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSimpleTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: ListTile(
        leading: Icon(icon, size: 20, color: Colors.black87),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () {},
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String title, Color bgColor, Color textColor) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18, color: textColor),
      label: Text(title, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: const Size(double.infinity, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: bgColor == Colors.white ? const BorderSide(color: Colors.grey) : BorderSide.none),
        elevation: 0,
      ),
    );
  }
}