import 'package:flutter/material.dart';

class StudentDetailsPage extends StatefulWidget {
  const StudentDetailsPage({super.key});

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  // Edit mode එක පාලනය කරන Variable එක
  bool isEditMode = false;

  // දත්ත රඳවා ගන්නා Controller (උදාහරණයක් ලෙස General tab එක සඳහා)
  final TextEditingController nameController = TextEditingController(text: "Emma Johnson");
  final TextEditingController dobController = TextEditingController(text: "3/15/2014");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Student Details", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("GuardianGo App", style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
          actions: [
            // --- Edit / Save Button එක මාරු වන කොටස ---
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 10, bottom: 10),
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    if (isEditMode) {
                      // මෙහිදී දත්ත Save කරන logic එක ලියන්න (Supabase update)
                      print("Data Saved!");
                    }
                    isEditMode = !isEditMode; // Mode එක මාරු කිරීම
                  });
                },
                icon: Icon(
                  isEditMode ? Icons.save_outlined : Icons.edit_outlined,
                  size: 18,
                  color: isEditMode ? Colors.green : Colors.black,
                ),
                label: Text(
                  isEditMode ? "Save" : "Edit",
                  style: TextStyle(color: isEditMode ? Colors.green : Colors.black),
                ),
                style: TextButton.styleFrom(
                  side: BorderSide(color: isEditMode ? Colors.green : Colors.grey, width: 0.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
          bottom: _buildTabBar(),
        ),
        body: TabBarView(
          children: [
            _buildGeneralTab(),
            const Center(child: Text("Medical Tab")),
            const Center(child: Text("Emergency Tab")),
            const Center(child: Text("Transport Tab")),
          ],
        ),
      ),
    );
  }
          // --- Custom Tab Bar Design ---
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TabBar(
                isScrollable: true,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black54,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                tabs: const [
                  Tab(text: "General"),
                  Tab(text: "Medical"),
                  Tab(text: "Emergency"),
                  Tab(text: "Transport"),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            GeneralTab(),
            MedicalTab(),
            EmergencyTab(),
            TransportTab(),
          ],
        ),
      ),
    );
  }
}

// --- 1. General Information Tab ---
class GeneralTab extends StatelessWidget {
  const GeneralTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _buildInfoContainer(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.image_outlined, size: 30),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Emma Johnson", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("Student ID: SE2024001", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(height: 5),
                    Chip(label: Text("Grade 5A", style: TextStyle(fontSize: 10)), visualDensity: VisualDensity.compact),
                  ],
                )
              ],
            ),
            const Divider(height: 30),
            _buildDataRow("Date of Birth", "3/15/2014", "School", "Sunshine Elementary School"),
            _buildDataRow("Grade", "5th Grade", "Class", "Grade 5A"),
            _buildDataRow("Room Number", "Room 205", "", ""),
            const Divider(),
            _buildLongData("Home Address", "123 Maple Street, Springfield, IL 62701"),
            const Divider(),
            _buildLongData("Parent Notes", "Emma gets nervous in new situations. Please give her a few extra minutes to adjust."),
          ],
        ),
      ),
    );
  }
}

// --- 2. Medical Information Tab ---
class MedicalTab extends StatelessWidget {
  const MedicalTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _buildInfoContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.favorite_border, color: Colors.red),
                SizedBox(width: 8),
                Text("Medical Information", style: TextStyle(fontSize: 16, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 20),
            _buildDataRow("Blood Type", "A+", "Insurance Provider", "Blue Cross Blue Shield"),
            _buildDataRow("Policy Number", "BC123456789", "", ""),
            const Divider(),
            _buildDataRow("Primary Physician", "Dr. Sarah Mitchell", "Physician Phone", "(555) 123-9876"),
            const Divider(),
            const Text("Allergies", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Row(children: [_buildTag("Peanuts", Colors.red), _buildTag("Tree nuts", Colors.red)]),
            const SizedBox(height: 15),
            const Text("Current Medications", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Row(children: [_buildTag("EpiPen Jr.", Colors.grey.shade200), _buildTag("Albuterol inhaler", Colors.grey.shade200)]),
            const SizedBox(height: 15),
            const Text("Medical Conditions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Row(children: [_buildTag("Asthma", Colors.grey.shade300), _buildTag("Food allergies", Colors.grey.shade300)]),
            const SizedBox(height: 15),
            _buildLongData("Special Needs & Instructions", "Requires inhaler during physical activities"),
            const SizedBox(height: 15),
            const Text("Dietary Restrictions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            Row(children: [_buildTag("Nut-free", Colors.grey.shade100), _buildTag("Shellfish-free", Colors.grey.shade100)]),
          ],
        ),
      ),
    );
  }
}

// --- 3. Emergency Contacts Tab ---
class EmergencyTab extends StatelessWidget {
  const EmergencyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: _buildInfoContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [Icon(Icons.phone_outlined, color: Colors.green), SizedBox(width: 8), Text("Emergency Contacts", style: TextStyle(fontSize: 16, color: Colors.grey))],
            ),
            const SizedBox(height: 15),
            _buildContactCard("Sarah Johnson", "Mother", "(555) 123-9876", "sarah.j@email.com", isPrimary: true),
            _buildContactCard("Mike Johnson", "Father", "(555) 987-6543", "mike.j@email.com"),
            _buildContactCard("Linda Martinez", "Grandmother", "(555) 456-7890", "linda.m@email.com"),
          ],
        ),
      ),
    );
  }
}

// --- 4. Transportation Details Tab ---
class TransportTab extends StatelessWidget {
  const TransportTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildInfoContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [Icon(Icons.directions_bus_outlined, color: Colors.blue), SizedBox(width: 8), Text("Transportation Details", style: TextStyle(fontSize: 16, color: Colors.grey))],
                ),
                const SizedBox(height: 20),
                _buildDataRow("Bus Route", "Route A-42", "Pickup Time", "7.45 AM"),
                _buildDataRow("Drop-off Time", "3.30 PM", "", ""),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildIconButton(Icons.location_on_outlined, "Track Bus"),
                    const SizedBox(width: 10),
                    _buildIconButton(Icons.bus_alert_outlined, "Bus Details"),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _buildIconButton(Icons.calendar_month_outlined, "View Attendance")),
              const SizedBox(width: 10),
              Expanded(child: _buildIconButton(Icons.history, "Trip History")),
            ],
          )
        ],
      ),
    );
  }
}

// --- Helper Widgets ---

Widget _buildInfoContainer({required Widget child}) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey.shade200),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
    ),
    child: child,
  );
}

Widget _buildDataRow(String label1, String val1, String label2, String val2) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15),
    child: Row(
      children: [
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label1, style: const TextStyle(color: Colors.grey, fontSize: 11)), Text(val1, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))])),
        if (label2.isNotEmpty)
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label2, style: const TextStyle(color: Colors.grey, fontSize: 11)), Text(val2, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13))])),
      ],
    ),
  );
}

Widget _buildLongData(String label, String val) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      const SizedBox(height: 4),
      Text(val, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, height: 1.4)),
    ],
  );
}

Widget _buildTag(String text, Color color) {
  return Container(
    margin: const EdgeInsets.only(right: 8, top: 5),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
    child: Text(text, style: TextStyle(fontSize: 10, color: color == Colors.red ? Colors.white : Colors.black87, fontWeight: FontWeight.bold)),
  );
}

Widget _buildContactCard(String name, String relation, String phone, String email, {bool isPrimary = false}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.grey.shade200)),
    child: Column(
      children: [
        Row(
          children: [
            if (isPrimary) Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5)), child: const Text("Primary", style: TextStyle(color: Colors.white, fontSize: 10))),
            const SizedBox(width: 5),
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(5)), child: const Text("Authorized Pickup", style: TextStyle(fontSize: 10))),
          ],
        ),
        const SizedBox(height: 10),
        _buildDataRow("Name", name, "Relationship", relation),
        _buildDataRow("Phone", phone, "Email", email),
      ],
    ),
  );
}

Widget _buildIconButton(IconData icon, String label) {
  return OutlinedButton.icon(
    onPressed: () {},
    icon: Icon(icon, size: 16, color: Colors.black),
    label: Text(label, style: const TextStyle(color: Colors.black, fontSize: 11)),
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );
}