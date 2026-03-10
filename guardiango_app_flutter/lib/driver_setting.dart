import 'package:flutter/material.dart';

class DriverSettingsPage extends StatefulWidget {
  const DriverSettingsPage({super.key});

  @override
  State<DriverSettingsPage> createState() => _DriverSettingsPageState();
}

class _DriverSettingsPageState extends State<DriverSettingsPage> {
  // Toggle Switches 
  bool parentMessages = true;
  bool routeUpdates = true;
  bool emergencyAlerts = true;
  bool soundAlerts = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Driver Settings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text("Manage your profile and preferences",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 1. Profile Card
            _buildProfileCard(),
            const SizedBox(height: 16),

            // 2. Contact Information
            _buildSectionHeader("Contact Information"),
            _buildContactInfoCard(),
            const SizedBox(height: 16),

            // 3. Notification Settings
            _buildSectionHeaderWithIcon("Notification Settings", Icons.notifications_none),
            _buildNotificationCard(),
            const SizedBox(height: 16),

            // 4. App Settings (GPS & Privacy)
            _buildSectionHeader("App Settings"),
            _buildNavigationCard([
              _buildListTile(Icons.location_on_outlined, "GPS Setting", "Manage Location Tracking"),
              const Divider(),
              _buildListTile(Icons.shield_outlined, "Privacy & Security", "Manage data and privacy setting"),
            ]),
            const SizedBox(height: 16),

            // 5. More Settings (Help & Support)
            _buildSectionHeader("App Settings"),
            _buildNavigationCard([
              _buildListTile(Icons.help_outline, "Help Center", "FAQs and guides"),
              const Divider(),
              _buildListTile(Icons.phone_in_talk_outlined, "Contact Support", "Get help from our team"),
            ]),
            const SizedBox(height: 20),

            // 6. App Version
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Text("App Version", style: TextStyle(color: Colors.grey, fontSize: 12)),
                  Text("Driver Portal v2.1.0", style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // 7. Logout Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFF5F5),
                  side: BorderSide.none,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildProfileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFE0E0E0),
                child: Icon(Icons.person, size: 50, color: Colors.black54),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("John Martinez", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  _iconLabel(Icons.directions_bus_outlined, "Bus A-42"),
                  const SizedBox(height: 4),
                  _iconLabel(Icons.location_on_outlined, "CDL-1234567"),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                side: BorderSide(color: Colors.grey.shade300),
              ),
              child: const Text("Edit Profile", style: TextStyle(color: Colors.black)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildContactTile(Icons.email_outlined, "Email", "john.martinez@schoolbus.com"),
          const SizedBox(height: 8),
          _buildContactTile(Icons.mail_outline, "Phone", "07X - XXXXXXX"),
        ],
      ),
    );
  }

  Widget _buildNotificationCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildSwitchTile("Parent Messages", "Receive notifications for new messages", parentMessages, (v) => setState(() => parentMessages = v)),
          _buildSwitchTile("Route Updates", "Get notified about route changes", routeUpdates, (v) => setState(() => routeUpdates = v)),
          _buildSwitchTile("Emergency Alerts", "Critical safety notifications", emergencyAlerts, (v) => setState(() => emergencyAlerts = v)),
          _buildSwitchTile("Sound Alerts", "Enable notification sounds", soundAlerts, (v) => setState(() => soundAlerts = v)),
        ],
      ),
    );
  }

  Widget _iconLabel(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12, left: 4),
        child: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
      ),
    );
  }

  Widget _buildSectionHeaderWithIcon(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildContactTile(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.black87),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTile(String title, String sub, bool val, Function(bool) onChanged) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      subtitle: Text(sub, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      trailing: Switch(
        value: val,
        onChanged: onChanged,
        activeThumbColor: Colors.white,
        activeTrackColor: Colors.black87,
      ),
    );
  }

  Widget _buildNavigationCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildListTile(IconData icon, String title, String sub) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, size: 20, color: Colors.black54),
      ),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      subtitle: Text(sub, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: () {},
    );
  }
}