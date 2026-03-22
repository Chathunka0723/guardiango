import 'dart:async';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Your existing imports
import 'package:guardiango_app_flutter/parent_bus_details.dart';
import 'package:guardiango_app_flutter/parent_chat.dart';
import 'package:guardiango_app_flutter/parent_emergency_contacts.dart';
import 'package:guardiango_app_flutter/parent_login.dart';
import 'package:guardiango_app_flutter/parent_lost_and_found.dart';
import 'package:guardiango_app_flutter/parent_preferences.dart';
import 'package:guardiango_app_flutter/parent_payment_1.dart';
import 'package:guardiango_app_flutter/attendance_tracker.dart';
import 'package:guardiango_app_flutter/parent_notification.dart';
import 'package:guardiango_app_flutter/parent_setting.dart';
import 'package:guardiango_app_flutter/student_info.dart';
import 'package:guardiango_app_flutter/map_screen.dart';

class ParentHomeScreen extends StatefulWidget {
  const ParentHomeScreen({super.key});

  @override
  State<ParentHomeScreen> createState() => _ParentHomeScreenState();
}

class _ParentHomeScreenState extends State<ParentHomeScreen> {
  final SupabaseClient supabase = Supabase.instance.client;

  String _greeting = "";
  String _currentTime = "";
  String _parentName = "Parent";
  bool _isLoading = true;
  Timer? _timer;
  StreamSubscription?
      _notificationSubscription; // Combined listener for all handshake steps

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _loadParentData();
    _listenToNotifications(); // Listen for Payments, Call Accepts, and Admissions

    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateDateTime();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _notificationSubscription?.cancel();
    super.dispose();
  }

  // --- REVISED NOTIFICATION LOGIC (JOINING SQL TO FLUTTER) ---
  void _listenToNotifications() {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    _notificationSubscription = supabase
        .from('notifications')
        .stream(primaryKey: ['id'])
        .eq('profile_id', user.id)
        .listen((List<Map<String, dynamic>> data) {
          if (data.isNotEmpty && mounted) {
            final latest = data.last;
            final String type = latest['type'] ?? 'GENERAL';
            final String message = latest['message'] ?? 'New notification';

            // Directing the handshake logic based on the 'type' column in your SQL table
            if (type == 'CALL_ACCEPTED') {
              _showActionDialog(
                  "Driver Ready",
                  "The driver accepted your request. You can call now!",
                  Icons.phone_in_talk);
            } else if (type == 'ADMISSION_PROPOSED') {
              _showAdmissionApprovalDialog(
                  latest['request_id']?.toString() ?? '');
            } else if (type == 'REGISTRATION_COMPLETE') {
              _showActionDialog(
                  "Registration Done",
                  "Your child is now registered for the bus.",
                  Icons.verified_user,
                  color: Colors.green);
            } else {
              // Standard SnackBar for payments or general alerts
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor:
                      type == 'PAYMENT' ? Colors.green : Colors.blueGrey,
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 4),
                ),
              );
            }
          }
        });
  }

  // Helper to show Handshake Popups
  void _showActionDialog(String title, String content, IconData icon,
      {Color color = Colors.blue}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        icon: Icon(icon, color: color, size: 40),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        content: Text(content, textAlign: TextAlign.center),
        actions: [
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Got it"),
            ),
          )
        ],
      ),
    );
  }

  // Helper for the Parent to Approve Admission
  void _showAdmissionApprovalDialog(String requestId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Approve Admission"),
        content: const Text(
            "The driver has sent an admission request. Do you want to register your child?"),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Later")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, foregroundColor: Colors.white),
            onPressed: () async {
              try {
                // UPDATE SQL: Parent approves the request
                await supabase
                    .from('requests')
                    .update({'status': 'APPROVED'}).eq('id', requestId);
                if (mounted) Navigator.pop(context);
              } catch (e) {
                debugPrint("Approval Error: $e");
              }
            },
            child: const Text("Approve"),
          ),
        ],
      ),
    );
  }

  // --- EXISTING DATA LOADING LOGIC ---
  Future<void> _loadParentData() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }
    try {
      final profile = await supabase
          .from('profile')
          .select()
          .eq('profile_id', user.id)
          .maybeSingle();
      if (mounted && profile != null) {
        setState(() {
          _parentName = profile['full_name']?.toString() ?? "Parent";
        });
      }
    } catch (e) {
      debugPrint("Error loading parent data: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _updateDateTime() {
    final now = DateTime.now();
    final hour = now.hour;
    if (hour < 12)
      _greeting = "Good Morning";
    else if (hour < 17)
      _greeting = "Good Afternoon";
    else
      _greeting = "Good Evening";

    final minute = now.minute.toString().padLeft(2, '0');
    final amPm = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    setState(() {
      _currentTime = "${hour12.toString().padLeft(2, '0')}:$minute $amPm";
    });
  }

  Future<void> _signOut() async {
    setState(() => _isLoading = true);
    try {
      await supabase.auth.signOut();
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const ParentLogin()),
          (route) => false);
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // --- UI BUILD (EXACTLY AS PER YOUR DESIGN) ---
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator(color: Colors.amber)));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopBar(context),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildStatusCard(),
                    const SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      childAspectRatio: 1.4,
                      children: [
                        _buildGridCard(context, Icons.person_outline,
                            "Student Info", "View details", Colors.blue, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const StudentDetailsPage()));
                        }),
                        _buildGridCard(context, Icons.calendar_month_outlined,
                            "Attendance", "View records", Colors.purple, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AttendanceTrackerPage()));
                        }),
                        _buildGridCard(
                            context,
                            Icons.access_time,
                            "Trip History",
                            "Past journeys",
                            Colors.green,
                            () {}),
                        _buildGridCard(context, Icons.chat_bubble_outline,
                            "Chat", "Contact Driver", Colors.orange, () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ChatPage()));
                        }),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildPaymentCard(),
                    const SizedBox(height: 15),
                    _buildMedicalAlert(),
                    const SizedBox(height: 20),
                    _buildActivityTimeline(),
                    const SizedBox(height: 20),
                    _buildListTile(
                        Icons.directions_bus_outlined, "Bus & Driver Details",
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BusDetailsScreen()));
                    }),
                    _buildListTile(Icons.inventory_2_outlined, "Lost & Found",
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LostAndFoundPage()));
                    }),
                    _buildListTile(Icons.phone_outlined, "Emergency Contacts",
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ParentEmergencyContact()));
                    }),
                    _buildListTile(Icons.settings_outlined, "Preferences", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PreferencesPage()));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI HELPER METHODS (KEPT THE SAME AS YOUR UI) ---
  Widget _buildTopBar(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
          color: const Color(0xFFFEF3C7),
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          const Icon(Icons.menu, color: Colors.black54),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("$_greeting, $_parentName",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
                Text(_currentTime,
                    style:
                        const TextStyle(fontSize: 10, color: Colors.black45)),
              ],
            ),
          ),
          IconButton(
              icon: const Icon(Icons.notifications_none),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationSettingsPage()))),
          IconButton(
              icon: const Icon(Icons.logout_outlined), onPressed: _signOut),
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF00C853), Color(0xFF009624)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white)),
              const SizedBox(width: 12),
              const Expanded(
                  child: Text("Parent Dashboard",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))),
              const Icon(Icons.directions_bus, color: Colors.white, size: 40),
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MapScreen(busId: 'bus_001'))),
            icon: const Icon(Icons.location_on, size: 16),
            label: const Text("Track Live"),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black26,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 35)),
          )
        ],
      ),
    );
  }

  Widget _buildGridCard(BuildContext context, IconData icon, String title,
      String sub, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade100)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 30),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(sub, style: const TextStyle(color: Colors.grey, fontSize: 10)),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.credit_card, color: Colors.orange),
          const SizedBox(width: 15),
          const Expanded(
              child: Text("Pay Your Driver",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          ElevatedButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => PayDriverPage())),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFACC15)),
            child: const Text("Pay Now"),
          )
        ],
      ),
    );
  }

  Widget _buildMedicalAlert() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFAFA),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.red.shade100)),
      child: const Text("Medical Alert: Emma Johnson has allergies",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildActivityTimeline() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade100)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Today's Activity",
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _timelineRow(Colors.green, "Boarded Bus #42", "7:45 AM"),
        ],
      ),
    );
  }

  Widget _timelineRow(Color color, String title, String time) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 12),
        const SizedBox(width: 15),
        Text(title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
        const Spacer(),
        Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
