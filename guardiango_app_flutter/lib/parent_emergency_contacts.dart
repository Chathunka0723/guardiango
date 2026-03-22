import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ParentEmergencyContact extends StatefulWidget {
  final bool scrollToFaq;
  const ParentEmergencyContact({super.key, this.scrollToFaq = false});

  @override
  State<ParentEmergencyContact> createState() => _ParentEmergencyContactState();
}

class _ParentEmergencyContactState extends State<ParentEmergencyContact> {
  final GlobalKey faqKey = GlobalKey();
  final ScrollController scrollController = ScrollController();
  bool _isSendingSOS = false; // This will track our loading state later

  @override
  void initState() {
    super.initState();
    // Logic for scrolling to FAQ if needed
    if (widget.scrollToFaq) {
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
  }

  // --- Send SOS to Supabase ---
  Future<void> _triggerSOS() async {
    // 1. Show the loading spinner
    setState(() => _isSendingSOS = true);

    try {
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        throw 'User not logged in';
      }

      // 2. Insert the alert into your Supabase table
      // Make sure your table name is 'emergency_alerts'
      await Supabase.instance.client.from('emergency_alerts').insert({
        'parent_id': user.id,
        'alert_type': 'SOS_BUTTON_PRESSED',
        'status': 'HIGH_PRIORITY',
        'message': 'Emergency SOS triggered by Parent',
        'created_at': DateTime.now().toIso8601String(),
      });

      // 3. Success Message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("🚨 SOS Alert Sent! Driver & School Notified."),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      // 4. Error Message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Error sending SOS: $e"),
              backgroundColor: Colors.black),
        );
      }
    } finally {
      // 5. Hide the loading spinner
      if (mounted) {
        setState(() => _isSendingSOS = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Emergency Contacts",
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Quick access to support",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            // SOS BOX
            _buildSOSBox(),

            // Transport Team Section
            _buildSectionCard(
              title: "Transport Team",
              child: Column(
                children: [
                  _buildContactTile(
                      "Transport Coordinator", "Sarah Mitchell", "5551234567"),
                  const SizedBox(height: 12),
                  _buildContactTile(
                      "Bus Driver", "Mike Johnson (Bus #42)", "5559876543"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- HELPER METHODS ---

  Widget _buildSOSBox() {
    return Container(
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
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Send immediate alert to all emergency contacts",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            // Logic: Disable button while sending, otherwise trigger SOS
            onPressed: _isSendingSOS ? null : _triggerSOS,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            // Logic: Show a red spinner while sending, otherwise show text
            child: _isSendingSOS
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Color(0xFFEF4444),
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    "Send SOS Alert",
                    style: TextStyle(
                      color: Color(0xFFEF4444),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        child,
      ]),
    );
  }

  Widget _buildContactTile(String role, String name, String phone) {
    return ListTile(
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(role),
      trailing: IconButton(
        icon: const Icon(Icons.phone, color: Colors.green),
        onPressed: () {
          // Logic for calling will go here!
        },
      ),
    );
  }
}
