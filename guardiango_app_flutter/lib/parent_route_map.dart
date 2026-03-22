import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/bus_details.dart';

class TransportDetailsUI extends StatelessWidget {
  const TransportDetailsUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildMapPlaceholder(),
                  const SizedBox(height: 16),
                  _buildRouteDetailsCard(),
                  const SizedBox(height: 16),
                  _buildRouteStopsCard(),
                  const SizedBox(height: 16),
                  _buildImportantNote(),
                  const SizedBox(height: 24),
                  _buildFullDetailsButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 1. Header with Gradient ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 50, bottom: 20, left: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFDC830), Color(0xFFF37335)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Route Map",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
              Text("Route A-101",
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  // --- 2. Interactive Map Placeholder ---
  Widget _buildMapPlaceholder() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Interactive Map",
              style: TextStyle(
                  color: Colors.blueGrey, fontWeight: FontWeight.w500)),
          Text("Route visualization coming soon",
              style: TextStyle(color: Colors.blueGrey, fontSize: 12)),
        ],
      ),
    );
  }

  // --- 3. Route Details Card ---
  Widget _buildRouteDetailsCard() {
    return _buildBaseCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Route Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8)),
                child: const Text("A - 101",
                    style:
                        TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _detailItem("Driver", "John Martinez"),
              _detailItem("Bus Number", "#42"),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _detailItem("Total Stops", "5"),
              _detailItem(
                  "Bus Arrival", "-30 mins"), // Fixed text from screenshot
            ],
          ),
        ],
      ),
    );
  }

  // --- 4. Route Stops (Timeline) ---
  Widget _buildRouteStopsCard() {
    return _buildBaseCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Route Stops",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 16),
          _stopItem("Main Street & Oak Avenue", "7:30 AM", Colors.green,
              badge: "Your Stop"),
          _stopLine(),
          _stopItem("Central Avenue & 5th Street", "7:35 AM", Colors.blue),
          _stopLine(),
          _stopItem("Maple Park", "7:42 AM", Colors.blue),
          _stopLine(),
          _stopItem("Lincoln Elementary School", "3:30 PM", Colors.red,
              badge: "Destination"),
        ],
      ),
    );
  }

  // --- 5. Important Note ---
  Widget _buildImportantNote() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFDE7),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFF59D)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.error, color: Color(0xFFA89100), size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Important Note",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA89100),
                        fontSize: 13)),
                Text(
                  "Actual pickup times may vary by ±5 minutes depending on traffic conditions. Please be ready 5 minutes before scheduled pickup time.",
                  style: TextStyle(color: Color(0xFFA89100), fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 6. Bottom Button ---
  Widget _buildFullDetailsButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF1B404),
          foregroundColor: const Color(0xFF705100),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TransportDetailsPage(),
            ),
          );
        },
        child: const Text("View Full Details",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  // --- Helpers ---
  Widget _buildBaseCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: child,
    );
  }

  Widget _detailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        Text(value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }

  Widget _stopItem(String title, String time, Color color, {String? badge}) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(Icons.location_on, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  if (badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: badge == "Your Stop"
                            ? const Color(0xFFE8F5E9)
                            : const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(badge,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: badge == "Your Stop"
                                  ? Colors.green
                                  : Colors.red)),
                    ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(time,
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _stopLine() {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      height: 30,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}
