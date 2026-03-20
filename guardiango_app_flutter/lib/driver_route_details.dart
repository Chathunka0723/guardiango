import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/map_screen.dart';

class RouteDetailsPage extends StatelessWidget {
  const RouteDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Route Details",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            Text("Morning Route - East District",
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Bus Number Green Card
            _buildBusInfoCard(),
            const SizedBox(height: 16),

            // 2. Current Stop Yellow Card
            _buildCurrentStopCard(context),
            const SizedBox(height: 24),

            // 3. All Stops Section
            const Text("All Stops",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildTimeline(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildBusInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF00C853), Color(0xFF00E676)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Bus Number",
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8)),
                child: const Text("Active",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const Text("A-42",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem("Total Stops", "8"),
              _buildStatItem("Completed", "2"),
              _buildStatItem("Remaining", "6"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCurrentStopCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFD600), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.near_me_outlined,
                  color: Color(0xFFC62828), size: 20),
              const SizedBox(width: 8),
              const Text("Current Stop",
                  style: TextStyle(
                      color: Color(0xFFC62828), fontWeight: FontWeight.w500)),
              const Spacer(),
              _badge("ETA: 2 min", const Color(0xFFFFD600), Colors.black87),
            ],
          ),
          const SizedBox(height: 16),
          const Text("Elm Street Station",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text("789 Elm Street",
              style: TextStyle(color: Colors.grey[600], fontSize: 13)),
          const SizedBox(height: 16),
          const Row(
            children: [
              Icon(Icons.access_time, size: 16, color: Colors.black87),
              SizedBox(width: 4),
              Text("7:55 AM", style: TextStyle(fontWeight: FontWeight.w500)),
              Spacer(),
              Icon(Icons.people_outline, size: 16, color: Colors.black87),
              SizedBox(width: 4),
              Text("3 Students",
                  style: TextStyle(color: Colors.black, fontSize: 13)),
            ],
          ),
          const Divider(height: 32),
          const Text("Students:",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          Row(
            children: [
              _studentChip("Sofia Rodriguez"),
              const SizedBox(width: 8),
              _studentChip("Carlos Martinez"),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MapScreen(busId: 'bus_001')),
              );
            },
            icon: const Icon(Icons.location_on_outlined,
                size: 18, color: Colors.black87),
            label: const Text("Open in Maps",
                style: TextStyle(color: Colors.black87)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD600),
              minimumSize: const Size(double.infinity, 45),
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          _timelineRow("Maple Street & 5th Ave", "123 Maple Street", "7:45 AM",
              "2 students", true, false, false),
          _timelineRow("Oak Park Plaza", "456 Oak Avenue", "7:50 AM",
              "3 students", true, false, false),
          _timelineRow("Elm Street Station", "789 Elm Street", "7:55 AM",
              "2 students", false, true, false),
          _timelineRow("Pine Grove Center", "321 Pine Grove Road", "8:00 AM",
              "1 student", false, false, false),
          _timelineRow("Cedar Lane Circle", "654 Cedar Lane", "8:05 AM",
              "3 students", false, false, false),
          _timelineRow("Birch Avenue Stop", "987 Birch Avenue", "8:10 AM",
              "2 students", false, false, false),
          _timelineRow("Willow Street Hub", "159 Willow Street", "8:15 AM",
              "3 students", false, false, false),
          _timelineRow("Sunshine Elementary School", "1000 Education Boulevard",
              "8:20 AM", "18 students", false, false, true),
        ],
      ),
    );
  }

  Widget _timelineRow(String title, String subtitle, String time,
      String students, bool isDone, bool isCurrent, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        children: [
          // Vertical Line & Dot logic
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCurrent
                      ? const Color(0xFFFFF9C4)
                      : (isDone ? const Color(0xFFE8F5E9) : Colors.grey[100]),
                ),
                child: Icon(
                  isDone
                      ? Icons.check_circle
                      : (isCurrent ? Icons.location_on : Icons.location_on),
                  size: 16,
                  color: isDone
                      ? const Color(0xFF4CAF50)
                      : (isCurrent
                          ? const Color(0xFFFBC02D)
                          : Colors.grey[300]),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2, color: Colors.grey[200]),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // Content Card
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isCurrent
                                    ? Colors.black87
                                    : (isDone ? Colors.black87 : Colors.grey))),
                      ),
                      if (isDone)
                        _badge("Done", const Color(0xFFE8F5E9),
                            const Color(0xFF4CAF50)),
                      if (isCurrent)
                        _badge("Now", const Color(0xFFFFEB3B), Colors.black87),
                    ],
                  ),
                  Text(subtitle,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.access_time,
                          size: 14, color: Colors.grey[400]),
                      const SizedBox(width: 4),
                      Text(time,
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 12)),
                      const SizedBox(width: 12),
                      Icon(Icons.people_outline,
                          size: 14, color: Colors.grey[400]),
                      const SizedBox(width: 4),
                      Text(students,
                          style:
                              TextStyle(color: Colors.grey[400], fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- SMALL HELPERS ---

  Widget _badge(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
      child: Text(text,
          style: TextStyle(
              color: textCol, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _studentChip(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Text(name,
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }
}
