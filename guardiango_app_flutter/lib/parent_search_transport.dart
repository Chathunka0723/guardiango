import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/transport_availability_results.dart';

class LocationSelectionScreen extends StatelessWidget {
  const LocationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9C4), // Light cream background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Top Gradient Header
              _buildHeader(),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // 2. Info Box (Blue)
                    _buildPlanRouteInfo(),

                    const SizedBox(height: 20),

                    // 3. Search Your Transport Card
                    _buildSearchTransportCard(context),

                    const SizedBox(height: 20),

                    // 4. Find Vehicle Card
                    _buildFindVehicleCard(context),

                    const SizedBox(height: 30),

                    // 5. Footer Text
                    const Text(
                      "We'll show you all available routes matching your selected locations",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Header with Gradient
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFD600), Color(0xFFFFAB40)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFC107),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.directions_bus, size: 30),
          ),
          const SizedBox(width: 15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search Your Transportation",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                "Find the perfect route for your child",
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Blue Info Box
  Widget _buildPlanRouteInfo() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: const Row(
        children: [
          Icon(Icons.location_on_outlined, color: Colors.blue, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Plan Your Route",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.blue)),
                Text(
                  "Select your pickup and drop-off locations to see available transportation options.",
                  style: TextStyle(fontSize: 10, color: Colors.blue),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Card 1: Search Your Transport
  Widget _buildSearchTransportCard(BuildContext context) {
    return _buildMainCard(
      title: "Search Your Transport",
      children: [
        _buildDropdownField("Pickup Location", "Select your pickup location",
            Icons.location_on_outlined),
        const SizedBox(height: 15),
        _buildDropdownField("Drop-off Location (School)",
            "Select your drop-off location", Icons.location_on_outlined),
        const SizedBox(height: 20),
        _buildActionButton("Find Transport", Icons.directions_bus, () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AvailableRoutesPage()),
          );
        }),
      ],
    );
  }

  // Card 2: Find Vehicle
  Widget _buildFindVehicleCard(BuildContext context) {
    return _buildMainCard(
      title: "Find Vehicle",
      children: [
        _buildDropdownField(
            "Vehicle ID", "Select Vehicle ID", Icons.credit_card_outlined),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Text("OR",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
        ),
        _buildDropdownField("Vehicle Plate Number",
            "Select Vehicle Plate Number", Icons.credit_card_outlined),
        const SizedBox(height: 20),
        _buildActionButton("Find Vehicle", Icons.directions_bus, () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const AvailableRoutesPage()),
          );
        }),
      ],
    );
  }

  // Helper for consistent card styling
  Widget _buildMainCard(
      {required String title, required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  // Helper for Dropdowns
  Widget _buildDropdownField(String label, String hint, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey, size: 18),
              const SizedBox(width: 10),
              Expanded(
                  child: Text(hint,
                      style: TextStyle(
                          color: Colors.grey.shade400, fontSize: 13))),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }

  // Helper for Yellow Buttons
  Widget _buildActionButton(
      String label, IconData icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFC107),
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 45),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
    );
  }
}
