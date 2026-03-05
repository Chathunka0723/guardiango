import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DriverhomeScreen extends StatefulWidget {
  const DriverhomeScreen({super.key});

  @override
  State<DriverhomeScreen> createState() => _DriverhomeScreenState();
}

class _DriverhomeScreenState extends State<DriverhomeScreen> {
  final SupabaseClient supabase = Supabase.instance.client;

  bool _isLoading = true;
  String driverName = "Loading...";
  String busNumber = "N/A";
  String routeName = "No active route";

  @override
  void initState() {
    super.initState();
    loadDriverData();
  }

  Future<void> loadDriverData() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }

    try {
      final responses = await Future.wait([
        supabase.from('profile').select().eq('profile_id', user.id).maybeSingle(),
        supabase.from('bus').select().eq('driver_id', user.id).maybeSingle(),
      ]);

      final profile = responses[0];
      final bus = responses[1];

      if (!mounted) return;

      setState(() {
        driverName = profile?['full_name']?.toString() ?? "John Martinez";
        busNumber = bus?['bus_number']?.toString() ?? "Bus NC - 0001";
        routeName = bus?['route_name']?.toString() ?? "Morning Route - East District";
      });
    } catch (e) {
      debugPrint("Error loading driver data: $e");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator(color: Color(0xFF00C853))) 
        : SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(), // Header UI
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildStatusCard(), // Route Info
                      const SizedBox(height: 20),
                      _buildActionGrid(), // Buttons
                      const SizedBox(height: 20),
                      _buildSectionHeader("Next Stops", "2 pending"),
                      _buildStudentTile("Sofia Rodriguez", "Elm Street Station", "7.55 A.M", "6th Grade", isOrange: true),
                      _buildStudentTile("Michael Chen", "Oak Avenue", "8.10 A.M", "4th Grade"),
                      const SizedBox(height: 20),
                      _buildSectionHeader("Students On Board", "12", badgeColor: Colors.green[100]),
                      _buildOnBoardTile("Emma Johnson", "5th Grade", hasAlert: true),
                      _buildOnBoardTile("David Smith", "3rd Grade"),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }


  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF00E676), Color(0xFF00C853)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Driver Dashboard", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  Text(routeName, style: const TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.settings_outlined, color: Colors.white)),
                ],
              )
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [
              const CircleAvatar(radius: 28, backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white, size: 30)),
              const SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(driverName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      const Icon(Icons.directions_bus, color: Colors.white70, size: 14),
                      const SizedBox(width: 5),
                      Text(busNumber, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatusCard() {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.grey[200]!)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.near_me, color: Colors.green[400], size: 18),
                    const SizedBox(width: 8),
                    const Text("Active Route Info", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Chip(label: const Text("Active", style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)), backgroundColor: Colors.green[50]),
              ],
            ),
            const Divider(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statColumn("18", "Total"),
                _statColumn("12", "Checked", color: Colors.green),
                _statColumn("2", "Pending", color: Colors.orange),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _statColumn(String val, String label, {Color color = Colors.black}) {
    return Column(
      children: [
        Text(val, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildActionGrid() {
    return Row(
      children: [
        Expanded(child: _actionBtn("Checked In", Icons.check_circle_outline, Colors.amber, Colors.white)),
        const SizedBox(width: 12),
        Expanded(child: _actionBtn("View Route", Icons.map_outlined, Colors.white, Colors.blue)),
      ],
    );
  }

  Widget _actionBtn(String title, IconData icon, Color bg, Color iconCol) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: bg, 
        borderRadius: BorderRadius.circular(12), 
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: bg != Colors.white ? [BoxShadow(color: bg.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4))] : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconCol),
          const SizedBox(width: 8),
          Text(title, style: TextStyle(color: bg == Colors.white ? Colors.black : Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String count, {Color? badgeColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(color: badgeColor ?? Colors.grey[200], borderRadius: BorderRadius.circular(10)),
            child: Text(count, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget _buildStudentTile(String name, String loc, String time, String grade, {bool isOrange = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isOrange ? const Color(0xFFFFF8E1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isOrange ? Colors.orange[100]! : Colors.grey[200]!),
      ),
      child: Row(
        children: [
          const CircleAvatar(radius: 20, backgroundColor: Colors.white, child: Icon(Icons.person_outline, color: Colors.blueGrey)),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), Text(loc, style: const TextStyle(fontSize: 11, color: Colors.grey))])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(time, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold, fontSize: 12)), Text(grade, style: const TextStyle(fontSize: 10, color: Colors.blueGrey))]),
        ],
      ),
    );
  }

  Widget _buildOnBoardTile(String name, String grade, {bool hasAlert = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[100]!)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.grey[100], child: const Icon(Icons.person, size: 20)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(grade, style: const TextStyle(fontSize: 11)),
        trailing: hasAlert ? const Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20) : const Icon(Icons.check_circle, color: Colors.green, size: 20),
      ),
    );
  }
}