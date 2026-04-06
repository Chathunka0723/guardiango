import 'package:flutter/material.dart';
import 'parent_notification.dart';
import 'parent_setting.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  // States for the switches
  bool _travelSummaries = true;
  bool _weekendNotifications = false;
  bool _holidayNotifications = true;
  bool _autoRefresh = true;

  String _selectedLanguage = "English";
  String _selectedTheme = "Light";
  String _selectedSound = "Chime";
  String _activeColorMode = "School";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Preferences",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text("Customize your experience",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit, size: 16),
              label: const Text("Edit"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.grey.shade300),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Alert Preferences ---
            _buildSectionCard(
              title: "Alert Preferences",
              titleIcon: Icons.notifications_none_outlined,
              iconColor: Colors.green,
              children: [
                _buildLabel("Alert Sound"),
                _buildDropdown(_selectedSound, ["Chime", "Bell", "None"],
                    (val) => setState(() => _selectedSound = val!)),
                const SizedBox(height: 16),
                _buildSwitchRow(
                    "Travel Summaries",
                    "Daily recap of your child's journey",
                    _travelSummaries,
                    (val) => setState(() => _travelSummaries = val)),
                _buildSwitchRow(
                    "Weekend Notifications",
                    "Receive alerts on weekends",
                    _weekendNotifications,
                    (val) => setState(() => _weekendNotifications = val)),
                _buildSwitchRow(
                    "Weekend Notifications", // Label from your design
                    "Get notified about school holidays",
                    _holidayNotifications,
                    (val) => setState(() => _holidayNotifications = val)),
              ],
            ),

            const SizedBox(height: 16),

            // --- App Behavior ---
            _buildSectionCard(
              title: "App Behavior",
              titleIcon: Icons.settings_outlined,
              iconColor: Colors.purpleAccent,
              children: [
                _buildSwitchRow(
                    "Auto Refresh",
                    "Automatically update bus location",
                    _autoRefresh,
                    (val) => setState(() => _autoRefresh = val)),
                const SizedBox(height: 8),
                _buildLabel("Language"),
                _buildDropdown(
                    _selectedLanguage,
                    ["English", "Sinhala", "Tamil"],
                    (val) => setState(() => _selectedLanguage = val!)),
              ],
            ),

            const SizedBox(height: 16),

            // --- Appearance ---
            _buildSectionCard(
              title: "Appearance",
              titleIcon: Icons.palette_outlined,
              iconColor: Colors.red,
              children: [
                _buildLabel("Theme"),
                _buildDropdown(_selectedTheme, ["Light", "Dark", "System"],
                    (val) => setState(() => _selectedTheme = val!)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildThemeTile(
                        "School", Colors.amber, _activeColorMode == "School"),
                    _buildThemeTile(
                        "Ocean", Colors.blue, _activeColorMode == "Ocean"),
                    _buildThemeTile(
                        "Nature", Colors.green, _activeColorMode == "Nature"),
                  ],
                )
              ],
            ),

            const SizedBox(height: 16),

            // --- Quick Access ---
            _buildSectionCard(
              title: "Quick Access",
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const NotificationSettingsPage()),
                      );
                    },
                    child: _buildQuickAccessButton(
                        Icons.notifications_none, "Notification Settings"),
                  ),
                ),
                const SizedBox(height: 10),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                      );
                    },
                    child: _buildQuickAccessButton(
                        Icons.settings_outlined, "App Settings"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // --- Save Button ---
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save_outlined),
                label: const Text("Save Preferences",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF28B446),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Helper Methods ---

  Widget _buildSectionCard(
      {required String title,
      IconData? titleIcon,
      Color? iconColor,
      required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (titleIcon != null)
                Icon(titleIcon, color: iconColor, size: 22),
              if (titleIcon != null) const SizedBox(width: 8),
              Text(title,
                  style: TextStyle(
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.w500,
                      fontSize: 15)),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchRow(
      String title, String subtitle, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor:
                const Color(0xFF333333), // Darker switch like the design
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildDropdown(
      String value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: items
              .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: const TextStyle(fontSize: 13))))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildThemeTile(String label, Color color, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _activeColorMode = label;
        });
        print("Selected Theme: $label");
      },
      child: Column(
        children: [
          Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color:
                  isSelected ? color.withOpacity(0.15) : color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color:
                      isSelected ? color.withOpacity(0.5) : Colors.transparent,
                  width: 1.5),
            ),
            child: Center(
              child: Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(6)),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(label,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButton(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.black87),
          const SizedBox(width: 12),
          Text(label,
              style:
                  const TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
