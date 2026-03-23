import 'package:flutter/material.dart';

// 1. DATA MODEL (Added this to organize your data professionally)
class BusRoute {
  final String id;
  final String from;
  final String to;
  final String timeRange;
  final String vehicleModel;
  final String driverName;
  final double rating;
  final String imageUrl;

  BusRoute({
    required this.id,
    required this.from,
    required this.to,
    required this.timeRange,
    required this.vehicleModel,
    required this.driverName,
    required this.rating,
    required this.imageUrl,
  });
}

void main() => runApp(const MaterialApp(home: AvailableRoutesScreen()));

class AvailableRoutesScreen extends StatelessWidget {
  const AvailableRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header Section ---
            Container(
              padding: const EdgeInsets.only(
                  top: 60, left: 20, right: 20, bottom: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFCD32D), Color(0xFFFF9800)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.arrow_back, color: Colors.white),
                  const SizedBox(height: 20),
                  const Text(
                    "Available Routes",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Select your preferred transportation",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  // Search Box Container
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildLocationRow(
                            Icons.radio_button_off, "From", "Wellampitiya"),
                        const Divider(color: Colors.white24, height: 25),
                        _buildLocationRow(Icons.location_on, "To",
                            "Royal College, Colombo 07"),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- Route Count Text ---
            const Padding(
              padding: EdgeInsets.all(16.0),
              child:
                  Text("1 route found", style: TextStyle(color: Colors.grey)),
            ),

            // --- Route Card ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    // Bus Image with Badge
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10)),
                          child: Image.network(
                            'https://example.com/school_bus.jpg', // Replace with your asset
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                color: Colors.yellow,
                                borderRadius: BorderRadius.circular(5)),
                            child: const Text("Route A-101",
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                    // Card Content
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          _buildRatingRow(),
                          const SizedBox(height: 10),
                          const Text(
                            "Wellampitiya to Royal College, Colombo 07",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Text("6:30 AM - 3:30 PM",
                              style: TextStyle(color: Colors.grey)),
                          const SizedBox(height: 15),
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.map_outlined),
                            label: const Text("View Route"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                              minimumSize: const Size(double.infinity, 45),
                            ),
                          ),
                          const SizedBox(height: 15),
                          _buildDetailRow("Vehicle Model:", "TATA CITY BUS"),
                          const Divider(),
                          _buildDetailRow("Driver:", "Sampath"),
                          const SizedBox(height: 15),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 45)),
                            child: const Text("More Details",
                                style: TextStyle(color: Colors.grey)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: const TextStyle(color: Colors.white70, fontSize: 12)),
            Text(value,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        )
      ],
    );
  }

  Widget _buildRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          5,
          (index) => Icon(Icons.star,
              color: index < 4 ? Colors.amber : Colors.grey[300]))
        ..add(const SizedBox(width: 8))
        ..add(const Text("4.8", style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
