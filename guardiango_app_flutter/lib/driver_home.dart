import 'package:flutter/material.dart';

class DriverhomeScreen extends StatelessWidget {
  const DriverhomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Green Header Section ---
            _buildHeader(),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildStatusCard(),
                  const SizedBox(height: 20),
                  _buildActionGrid(),
                  const SizedBox(height: 20),
                  
                  // Next Stops Section
                  _buildSectionHeader("Next Stops", "2 pending"),
                  _buildStudentTile("Sofia Rodriguez", "Elm Street Station", "7.55 A.M", "6th Grade", isOrange: true),
                  _buildStudentTile("Michael Chen", "Oak Avenue", "8.10 A.M", "4th Grade"),

                  const SizedBox(height: 20),

                  // Students On Board Section
                  _buildSectionHeader("Students On Board", "12", badgeColor: Colors.green[100]),
                  _buildOnBoardTile("Emma Johnson", "5th Grade", hasAlert: true),
                  _buildOnBoardTile("David Smith", "3rd Grade"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Header UI ---
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
      decoration: const BoxDecoration(
        color: Color(0xFF00C853), // Green theme from image
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Driver Dashboard", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("01:21 PM", style: TextStyle(color: Colors.white70)),
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.white)),
                  IconButton(onPressed: () {}, icon: const Icon(Icons.settings, color: Colors.white)),
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              CircleAvatar(radius: 25, backgroundColor: Colors.white24, child: Icon(Icons.person, color: Colors.white)),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("John Martinez", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  Text("Bus NC - 0001", style: TextStyle(color: Colors.white70)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  // --- Status Card (Active Route) ---
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
                const Text("Morning Route - East District", style: TextStyle(fontWeight: FontWeight.bold)),
                Chip(label: const Text("Active", style: TextStyle(color: Colors.green, fontSize: 10)), backgroundColor: Colors.green[50]),
              ],
            ),
            const Divider(),
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
        Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  // --- Grid Actions ---
  Widget _buildActionGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 2.5,
      children: [
        _actionBtn("Student Checked In", Icons.qr_code_scanner, Colors.amber, Colors.white),
        _actionBtn("View Route", Icons.map_outlined, Colors.white, Colors.blue),
      ],
    );
  }

  Widget _actionBtn(String title, IconData icon, Color bg, Color iconCol) {
    return Container(
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey[200]!)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconCol),
          const SizedBox(width: 8),
          Text(title, style: TextStyle(color: bg == Colors.white ? Colors.black : Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // --- List Tiles ---
  Widget _buildSectionHeader(String title, String count, {Color? badgeColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(color: badgeColor ?? Colors.grey[200], borderRadius: BorderRadius.circular(10)),
            child: Text(count, style: const TextStyle(fontSize: 12)),
          )
        ],
      ),
    );
  }

  Widget _buildStudentTile(String name, String loc, String time, String grade, {bool isOrange = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isOrange ? const Color(0xFFFFF8E1) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isOrange ? Colors.orange[100]! : Colors.grey[200]!),
      ),
      child: Row(
        children: [
          const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person_outline)),
          const SizedBox(width: 10),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.bold)), Text(loc, style: const TextStyle(fontSize: 12, color: Colors.grey))])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [Text(time, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)), Text(grade, style: const TextStyle(fontSize: 11))]),
        ],
      ),
    );
  }

  Widget _buildOnBoardTile(String name, String grade, {bool hasAlert = false}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(child: Icon(Icons.person)),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(grade),
      trailing: hasAlert ? const Icon(Icons.warning, color: Colors.red) : const Icon(Icons.check_circle, color: Colors.green),
    );
  }
}