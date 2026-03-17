import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  const NotificationSettingsPage({super.key});

  @override
  State<NotificationSettingsPage> createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // Toggle states
  bool busDeparture = true;
  bool busArrival = true;
  bool childBoarding = true;
  bool delays = true;
  bool earlyDismissal = false;
  bool weatherAlerts = true;
  bool sound = true;
  bool vibration = true;

  TimeOfDay startTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 6, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Notification Settings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text("Customize your alerts",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Journey Notifications ---
            _buildSectionCard(
              icon: Icons.notifications_none_outlined,
              iconColor: Colors.blue,
              title: "Journey Notifications",
              children: [
                _buildSwitchTile(
                    "Bus Departure",
                    "When the bus leaves the depot",
                    busDeparture,
                    (v) => setState(() => busDeparture = v)),
                _buildSwitchTile(
                    "Bus Arrival",
                    "When the bus arrives at pickup/drop",
                    busArrival,
                    (v) => setState(() => busArrival = v)),
                _buildSwitchTile(
                    "Child Boarding",
                    "When your child boards the bus",
                    childBoarding,
                    (v) => setState(() => childBoarding = v)),
                _buildSwitchTile("Delays", "When there are route delays",
                    delays, (v) => setState(() => delays = v)),
              ],
            ),
            const SizedBox(height: 16),

            // --- School Notifications ---
            _buildSectionCard(
              icon: Icons.warning_amber_rounded,
              iconColor: Colors.orange,
              title: "School Notifications",
              children: [
                _buildSwitchTile(
                    "Early Dismissal",
                    "School closure or early dismissal alerts",
                    earlyDismissal,
                    (v) => setState(() => earlyDismissal = v)),
                _buildSwitchTile(
                    "Weather Alerts",
                    "Severe weather affecting transport",
                    weatherAlerts,
                    (v) => setState(() => weatherAlerts = v)),
              ],
            ),
            const SizedBox(height: 16),

            // --- Do Not Disturb ---
            _buildSectionCard(
              icon: Icons.access_time,
              iconColor: Colors.purple,
              title: "Do Not Disturb",
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: Text(
                      "Set quiet hours when you won't receive notifications",
                      style: TextStyle(color: Colors.grey, fontSize: 12)),
                ),
                Row(
                  children: [
                    _buildTimePicker("Start Time", startTime, (newTime) {
                      setState(() => startTime = newTime);
                    }),
                    const SizedBox(width: 15),
                    _buildTimePicker("End Time", endTime, (newTime) {
                      setState(() => endTime = newTime);
                    }),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --- Notification Style ---
            _buildSectionCard(
              title: "Notification Style",
              children: [
                _buildSwitchTile("Sound", "Play notification sounds", sound,
                    (v) => setState(() => sound = v)),
                _buildSwitchTile("Vibration", "Vibrate on notifications",
                    vibration, (v) => setState(() => vibration = v)),
              ],
            ),
            const SizedBox(height: 30),

            // --- Save Button ---
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.check_circle_outline),
                label: const Text("Save Settings",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(0xFF2ecc71), // Green color from image
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

  Widget _buildSectionCard(
      {IconData? icon,
      Color? iconColor,
      required String title,
      required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) Icon(icon, color: iconColor, size: 22),
              if (icon != null) const SizedBox(width: 10),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          ...children,
        ],
      ),
    );
  }

  Widget _buildSwitchTile(
      String title, String subtitle, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(subtitle,
                    style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: Colors.grey.shade800,
          ),
        ],
      ),
    );
  }

  Widget _buildTimePicker(
      String label, TimeOfDay time, Function(TimeOfDay) onTimeChange) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          InkWell(
            onTap: () async {
              final TimeOfDay? picked =
                  await showTimePicker(context: context, initialTime: time);
              if (picked != null && picked != time) {
                onTimeChange(picked);
              }
            },
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(time.format(context)),
                  const Icon(Icons.keyboard_arrow_down, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
