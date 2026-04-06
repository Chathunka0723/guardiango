import 'package:flutter/material.dart';
import 'parent_home.dart';
import 'transport_availability_results.dart';

class TransportDetailsScreen extends StatelessWidget {
  const TransportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transport Details"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Driver: Sampath",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text("Bus: NC-0001"),
            const Text("Vehicle: TATA CITY BUS"),
            const Text("Seats Available: 5"),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ParentHomeScreen(),
                  ),
                );
              },
              child: const Text("Select This Transport"),
            ),
          ],
        ),
      ),
    );
  }
}
