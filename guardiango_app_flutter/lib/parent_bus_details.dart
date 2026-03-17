import 'package:flutter/material.dart';

class BusDetailsScreen extends StatelessWidget {
  const BusDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bus Details",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Emma Johnson's Bus",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 1. YELLOW BUS INFO HEADER
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFD60A), Color(0xFFFFC300)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Bus #42",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Route A - Sunshine\nDistrict",
                        style: TextStyle(
                          fontSize: 14,
                          color: const Color(0xFF1F2937).withOpacity(0.8),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "28/45",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Passengers",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF1F2937).withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 2. DRIVER & ASSISTANT SECTION
            _buildSectionCard(
              title: "Driver & Assistant",
              icon: Icons.group_outlined,
              child: Column(
                children: [
                  _buildPersonTile(
                    name: "Mike Johnson",
                    role: "Primary Driver",
                    sub: "12 years experience",
                    rating: "4.9",
                    showChat: true,
                    onCall: () => print("Calling Mike Johnson"),
                    onMessage: () => print("Messaging Mike Johnson"),
                  ),
                  const Divider(height: 24),
                  _buildPersonTile(
                    name: "Lisa Parker",
                    role: "Bus Assistant",
                    sub: "Student supervision & safety",
                    showChat: false,
                    onCall: () => print("Calling Lisa Parker"),
                  ),
                ],
              ),
            ),

            // 3. CURRENT STATUS SECTION
            _buildSectionCard(
              title: "Current Status",
              icon: Icons.location_on_outlined,
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildStatusBox("En Route", Colors.green, "Status"),
                      const SizedBox(width: 12),
                      _buildStatusBox("8 min", Colors.blue, "ETA"),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDataRow("Next Stop", "Maple Street & 5th Ave"),
                  _buildDataRow("Speed", "25 mph"),
                  _buildDataRow("Last Update", "2 minutes ago"),
                ],
              ),
            ),

            // 4. SAFETY FEATURES (Fixed Alignment)
            _buildSectionCard(
              title: "Safety Features",
              icon: Icons.shield_outlined,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildTag("GPS Tracking")),
                      const SizedBox(width: 10),
                      Expanded(child: _buildTag("Security Cameras")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildTag("Emergency Exit")),
                      const SizedBox(width: 10),
                      Expanded(child: _buildTag("First Aid Kit")),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildTag("Fire Extinguisher")),
                      const SizedBox(width: 10),
                      Expanded(child: _buildTag("Two-way Radio")),
                    ],
                  ),
                ],
              ),
            ),

            // 5. MAINTENANCE
            _buildSectionCard(
              title: "Maintenance",
              icon: Icons.build_outlined,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildMaintenanceCol("Last Service", "7/15/2024"),
                      _buildMaintenanceCol("Next Service", "8/15/2024"),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle,
                            color: Colors.green.shade600, size: 16),
                        const SizedBox(width: 8),
                        Text("All safety inspections up to date",
                            style: TextStyle(
                                color: Colors.green.shade700, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 6. BOTTOM BUTTONS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildOutlineButton(
                              Icons.location_searching, "Track Live")),
                      const SizedBox(width: 12),
                      Expanded(
                          child: _buildOutlineButton(
                              Icons.phone_in_talk, "Emergency")),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade50,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.redAccent),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: Colors.white,
                      ),
                      child: const Text("Report an Issue with this Bus",
                          style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI HELPER METHODS ---

  Widget _buildSectionCard(
      {required String title, required IconData icon, required Widget child}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 20),
              const SizedBox(width: 10),
              Text(title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildPersonTile({
    required String name,
    required String role,
    required String sub,
    String? rating,
    bool showChat = false,
    VoidCallback? onCall,
    VoidCallback? onMessage,
  }) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade100,
          child: const Icon(Icons.person_outline, color: Colors.black54),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              Text(role,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              Text(sub,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
              if (rating != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 14),
                    const SizedBox(width: 4),
                    Text(rating,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ]
            ],
          ),
        ),
        _buildCircleIcon(Icons.phone, Colors.green, onTap: onCall),
        if (showChat) ...[
          const SizedBox(width: 8),
          _buildCircleIcon(Icons.chat_bubble_outline, Colors.white,
              iconColor: Colors.black54, onTap: onMessage),
        ]
      ],
    );
  }

  Widget _buildCircleIcon(IconData icon, Color bg,
      {Color iconColor = Colors.white, VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: bg,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4)
            ],
            border: bg == Colors.white
                ? Border.all(color: Colors.grey.shade200)
                : null,
          ),
          child: Icon(icon, color: iconColor, size: 18),
        ),
      ),
    );
  }

  Widget _buildStatusBox(String val, Color color, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: color.withOpacity(0.05),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                  color: color.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8)),
              child: Text(val,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
            const SizedBox(height: 8),
            Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 11)),
          ],
        ),
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(Icons.circle, color: Colors.deepPurple.shade300, size: 8),
          const SizedBox(width: 8),
          Text(text,
              style:
                  const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildMaintenanceCol(String label, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
        const SizedBox(height: 4),
        Text(date,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _buildOutlineButton(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black87,
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
