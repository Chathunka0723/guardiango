import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:guardiango_app_flutter/attendance_tracker.dart';
import 'package:guardiango_app_flutter/parent_notification.dart';
import 'package:guardiango_app_flutter/parent_setting.dart';
import 'package:guardiango_app_flutter/student_info.dart';

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

  @override
  void initState() {
    super.initState();
    _updateDateTime();
    _loadParentData();
    
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateDateTime();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

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
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Custom Top Bar
              _buildTopBar(context),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // 2. Main Student Status Card (Green Card)
                    _buildStatusCard(),

                    const SizedBox(height: 20),

                    // 3. Four Grid Buttons (Student Info, Attendance, etc.)
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
                                    builder: (context) => const StudentDetailsPage()),
                              );
                        }),

                        _buildGridCard(context, Icons.calendar_month_outlined,
                            "Attendance", "View records", Colors.purple, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const AttendanceTrackerPage()),
                              );
                        }),

                        _buildGridCard(context, Icons.access_time,
                            "Trip History", "Past journeys", Colors.green, () {
                          print("Navigating to Trip History...");
                        }),

                        _buildGridCard(context, Icons.chat_bubble_outline,
                            "Chat", "Contact Driver", Colors.orange, () {
                          print("Navigating to Chat...");
                        }),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // 4. Pay Your Driver Section
                    _buildPaymentCard(),

                    const SizedBox(height: 15),

                    // 5. Medical Alert Section
                    _buildMedicalAlert(),

                    const SizedBox(height: 20),

                    // 6. Today's Activity (Timeline)
                    _buildActivityTimeline(),

                    const SizedBox(height: 20),

                    // 7. Bottom List Items
                    _buildListTile(
                        Icons.directions_bus_outlined, "Bus & Driver Details",
                        () {
                      print("Navigating to Bus & Driver Details...");
                    }),
                    _buildListTile(Icons.inventory_2_outlined, "Lost & Found",
                        () {
                      print("Navigating to Lost & Found...");
                    }),
                    _buildListTile(Icons.phone_outlined, "Emergency Contacts",
                        () {
                      print("Navigating to Emergency Contacts...");
                    }),
                    _buildListTile(Icons.settings_outlined, "Preferences", () {
                      print("Navigating to Preferences...");
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

  // Header Component
  Widget _buildTopBar(BuildContext context) {
    // Context eka parameter ekak widiyata ganna
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black54),
            onPressed: () {
              print(" Side menu button pressed");
            },
          ),
          const Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Good Morning, Emma",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text("01:59 PM",
                    style: TextStyle(fontSize: 10, color: Colors.black45)),
              ],
            ),
          ),

          // Notification Button
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
            onPressed: () {
              // Open notification settings page
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationSettingsPage()),
              );
            },
          ),

          const SizedBox(width: 5),

          // Settings Button (Clickable karanna ona nam IconButton ekak danna puluwan)
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.black54),
            onPressed: () {
              // Open settings page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
    );
  }

  // Green Status Card
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Emma Johnson",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    Text("Grade 10",
                        style: TextStyle(color: Colors.white70, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.directions_bus, color: Colors.white, size: 40),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Current Status",
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                  Text("ETA to School",
                      style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("On the bus",
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ),
                  const Text("8 minutes",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.location_on, size: 16),
            label: const Text("Track Live"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black26,
              foregroundColor: Colors.white,
              elevation: 0,
              minimumSize: const Size(double.infinity, 35),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
          )
        ],
      ),
    );
  }

  // Grid Buttons
  Widget _buildGridCard(BuildContext context, IconData icon, String title,
      String sub, Color color, VoidCallback onTap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 30),
              const SizedBox(height: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14)),
              Text(sub,
                  style: const TextStyle(color: Colors.grey, fontSize: 10)),
            ],
          ),
        ),
      ),
    );
  }

  // Payment Card
  Widget _buildPaymentCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFBEB),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFFFEF3C7))),
      child: Row(
        children: [
          const Icon(Icons.credit_card, color: Colors.orange, size: 30),
          const SizedBox(width: 15),
          const Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Pay Your Driver",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Quick & secure payment",
                  style: TextStyle(fontSize: 10, color: Colors.grey)),
            ]),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFACC15),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            child: const Text("Pay Now",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  // Medical Alert
  Widget _buildMedicalAlert() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFAFA),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.red.shade100)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            Icon(Icons.favorite_border, color: Colors.red.shade400, size: 20),
            const SizedBox(width: 8),
            Text("Medical Alert",
                style: TextStyle(
                    color: Colors.red.shade900, fontWeight: FontWeight.bold))
          ]),
          const SizedBox(height: 5),
          const Text("Emma Johnson has allergies: Peanuts, Tree nuts",
              style: TextStyle(fontSize: 11, color: Colors.redAccent)),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.red.shade200),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(double.infinity, 30)),
            child: const Text("View Full Medical Info",
                style: TextStyle(fontSize: 11, color: Colors.red)),
          )
        ],
      ),
    );
  }

  // Activity Timeline
  Widget _buildActivityTimeline() {
    return Container(
      width: double.infinity,
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
          const SizedBox(height: 15),
          _timelineRow(
              Colors.green, "Boarded Bus #42", "7:45 AM • Home pickup"),
          const SizedBox(height: 15),
          _timelineRow(Colors.blue, "En route to school",
              "7:52 AM • 8 minutes remaining"),
        ],
      ),
    );
  }

  Widget _timelineRow(Color color, String title, String time) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 12),
        const SizedBox(width: 15),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          Text(time, style: const TextStyle(fontSize: 10, color: Colors.grey)),
        ])
      ],
    );
  }

  // Bottom List Tiles
  Widget _buildListTile(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade100)),
      child: ListTile(
        leading: Icon(icon, color: Colors.black87, size: 20),
        title: Text(title,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
        dense: true,
      ),
    );
  }
}
