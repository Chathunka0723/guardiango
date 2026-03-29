import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/driver_home.dart';

class RegistrationApprovedScreen extends StatelessWidget {
  final String vehicleCode;

  const RegistrationApprovedScreen({super.key, required this.vehicleCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 20),

            const Text(
              "Registration Approved!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text("Your Vehicle ID"),

            const SizedBox(height: 10),

            Text(
              vehicleCode ?? "",
              style: const TextStyle(
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

                        const SizedBox(height: 30),

            
            SizedBox(
              width: 200,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DriverhomeScreen(
                        busId: vehicleCode ?? "",
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C853),
                ),
                child: const Text("Go to Dashboard"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
     