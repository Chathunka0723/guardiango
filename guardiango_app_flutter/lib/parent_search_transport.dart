import 'package:flutter/material.dart';

class LocationSelectionScreen extends StatelessWidget {
  const LocationSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF9C4), // Light yellowish background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 1. Top Gradient Header
              _buildHeader(),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // 2. Info Box (Blue)
                    _buildRouteInfo(),

                    const SizedBox(height: 25),

                    // 3. Selection Main Card (White)
                    _buildSelectionCard(),

                    const SizedBox(height: 40),

                    // 4. Bottom Footer Text
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "We'll show you all available routes matching your selected locations",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Header Component with Gradient and Icon
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFFFFC107), Color(0xFFFF9800)],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.directions_bus,
                color: Colors.black87, size: 30),
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
          ),
        ],
      ),
    );
  }

  // Blue Info Box
  Widget _buildRouteInfo() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFBBDEFB)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.location_on_outlined, color: Colors.blue, size: 20),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Plan Your Route",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF0D47A1)),
                ),
                SizedBox(height: 4),
                Text(
                  "Select your pickup and drop-off locations to see available transportation options.",
                  style: TextStyle(fontSize: 11, color: Color(0xFF1976D2)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Main White Selection Card
  Widget _buildSelectionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Select your pickup and drop-off",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 25),

          _buildDropdownField("Pickup Location", "Select your pickup location"),
          const SizedBox(height: 20),

          _buildDropdownField(
              "Drop-off Location (School)", "Select your drop-off location"),
          const SizedBox(height: 30),

          // Find Transport Button
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.directions_bus, size: 18),
            label: const Text("Find Transport"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFC107),
              foregroundColor: Colors.black,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Dropdown UI
  Widget _buildDropdownField(String label, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined,
                  color: Colors.grey.shade400, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  hint,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            ],
          ),
        ),
      ],
    );
  }
}
