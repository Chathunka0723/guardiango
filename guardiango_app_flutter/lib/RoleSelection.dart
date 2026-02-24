import 'package:flutter/material.dart';
import 'package:flutter_sdgp_app/screen/DriverLogin.dart';
import 'package:flutter_sdgp_app/screen/ParentLogin.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF3C7), // Splash screen එකේම background වර්ණය
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              // logo and name
              Column(
                children: [
                  Image.asset('assets/bus_logo.png', height: 60),
                  const Text(
                    'GuardianGo',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),

              // Topic
              const Text(
                'Select Your Role',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Let's get you start.",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),

              const SizedBox(height: 40),

              // Parent Selection Card
              _buildRoleCard(
                imagePath: 'assets/parent_logo.png',
                title: 'Parent',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ParentLogin()),
                  );
                },
              ),

              const SizedBox(height: 20),

              // 4. Driver Selection Card
              _buildRoleCard(
                imagePath: 'assets/driver_logo.png',
                title: 'Driver',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DriverLogin()),
                  );
                },
              ),

              const Spacer(),

              const Text(
                'Your role determines what information you can access.\nAll data is encrypted and securely stored.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.black54),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Role Card Function
  Widget _buildRoleCard({
    required String imagePath,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: const Color(0xFFEAB308), 
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(imagePath, height: 80), // Icons
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}