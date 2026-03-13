import 'package:flutter/material.dart';

class ParentEmergencyContact extends StatelessWidget {
  final bool scrollToFaq;
  final GlobalKey faqKey = GlobalKey();
  final ScrollController scrollController = ScrollController();

  ParentEmergencyContact({super.key, this.scrollToFaq = false});

  @override
  Widget build(BuildContext context) {
    if (scrollToFaq) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (faqKey.currentContext != null) {
          Scrollable.ensureVisible(
            faqKey.currentContext!,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
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
              "Emergency Contacts",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Quick access to support",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            // 1. EMERGENCY SOS BOX
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: Colors.white, size: 40),
                  const SizedBox(height: 12),
                  const Text(
                    "Emergency SOS",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Send immediate alert to all emergency contacts",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.shield_outlined,
                        color: Color(0xFFEF4444)),
                    label: const Text("Send SOS Alert",
                        style: TextStyle(color: Color(0xFFEF4444))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),

            // 2. TRANSPORT TEAM SECTION
            _buildSectionCard(
              title: "Transport Team",
              child: Column(
                children: [
                  _buildContactTile("Transport Coordinator", "Sarah Mitchell",
                      "(555) 123-4567"),
                  const SizedBox(height: 12),
                  _buildContactTile(
                      "Bus Driver", "Mike Johnson (Bus #42)", "(555) 987-6543"),
                  const SizedBox(height: 12),
                  _buildContactTile(
                      "School Office", "Sunshine Elementary", "(555) 456-7890"),
                ],
              ),
            ),

            // 3. ACTION BUTTONS
            _buildActionButton(
                Icons.report_problem_outlined,
                "Report a Problem",
                "Bus issues, delays, or safety concerns",
                Colors.redAccent),
            _buildActionButton(Icons.access_time, "Check Bus Status",
                "Real-time location and delays", Colors.blue),

            // 4. FAQ SECTION
            Container(
              key: faqKey,
              child: _buildSectionCard(
                title: "Frequently Asked Questions",
                child: Column(
                  children: [
                    _buildFaqItem(
                        "What if my child misses the bus?",
                        "Contact the school office immediately. Alternative transport arrangements can be made.",
                        Colors.blue),
                    _buildFaqItem(
                        "How early should my child be at the stop?",
                        "Children should be at the bus stop 5 minutes before the scheduled pickup time.",
                        Colors.green),
                    _buildFaqItem(
                        "What happens during bad weather?",
                        "You'll receive notifications about delays or cancellations. Check the app for updates.",
                        Colors.red),
                  ],
                ),
              ),
            ),

            // 5. EMERGENCY PROTOCOL
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.red.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.radio_button_unchecked,
                          color: Colors.red.shade400, size: 16),
                      const SizedBox(width: 8),
                      const Text("Emergency Protocol",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "In case of a serious emergency, call 911 first, then use the SOS button above to alert school contacts. This ensures the fastest response time.",
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ], // End of Column children
        ), // End of Column
      ), // End of SingleChildScrollView
    ); // End of Scaffold
  } // End of build method

  // --- UI HELPERS ---

  Widget _buildSectionCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
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
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _buildContactTile(String role, String name, String phone) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 2),
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
          ),
          _buildActionIcon(Icons.phone, Colors.green, "Call $name", () {
            debugPrint("Initiating call to $phone");
          }),
          const SizedBox(width: 8),
          _buildActionIcon(
              Icons.chat_bubble_outline, Colors.white, "Message $name", () {
            debugPrint("Opening chat with $phone");
          }, isBordered: true),
        ],
      ),
    );
  }

  Widget _buildActionIcon(
      IconData icon, Color bg, String tooltip, VoidCallback onTap,
      {bool isBordered = false}) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        onPressed: onTap,
        tooltip: tooltip,
        hoverColor:
            bg == Colors.white ? Colors.grey.shade100 : bg.withOpacity(0.2),
        constraints: const BoxConstraints(),
        padding: const EdgeInsets.all(10),
        style: IconButton.styleFrom(
          backgroundColor: bg,
          side: isBordered ? BorderSide(color: Colors.grey.shade200) : null,
        ),
        icon: Icon(
          icon,
          color: bg == Colors.white ? Colors.grey.shade500 : Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildActionButton(
      IconData icon, String title, String sub, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            debugPrint("Navigating to: $title");
          },
          hoverColor: color.withOpacity(0.05),
          splashColor: color.withOpacity(0.1),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(icon, color: color, size: 30),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      Text(sub,
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 12)),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer, Color sideColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 4, height: 40, color: sideColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(question,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 4),
                Text(answer,
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
