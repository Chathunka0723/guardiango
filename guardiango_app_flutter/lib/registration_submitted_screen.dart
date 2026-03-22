import 'package:flutter/material.dart';

class RegistrationSubmittedScreen extends StatelessWidget {
  const RegistrationSubmittedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 80),

            // ✅ Top Icon
            const CircleAvatar(
              radius: 40,
              backgroundColor: Color(0xFF00C853),
              child: Icon(Icons.check, color: Colors.white, size: 40),
            ),

            const SizedBox(height: 20),

            const Text(
              "Registration Submitted!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 5),

            const Text(
              "Your registration is under review",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            //Card 1
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.access_time, color: Colors.orange),
                    title: Text("Under Review"),
                    subtitle: Text("We are checking your details"),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("Email Confirmation"),
                    subtitle: Text("Check your email"),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // note
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "Approval usually takes 1-2 days",
                style: TextStyle(fontSize: 12),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}