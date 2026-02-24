import 'dart:async'; // Timer
import 'package:flutter/material.dart';
import 'package:flutter_sdgp_app/screen/RoleSelection.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  
  @override
  void initState() {
    super.initState();
    // After 3 seconds 
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RoleSelectionScreen()),
      );
      print("Navigating to next screen...");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEF3C7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),

            // Bus Logo
            Container(
              height: 120,
              width: 120,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bus_logo.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            const SizedBox(height: 20),

            // GuardianGo Title
            const Text(
              'GuardianGo',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F2937),
                letterSpacing: 0.5,
              ),
            ),

            const SizedBox(height: 8),

            // Tagline
            const Text(
              'Safe Ride, Every Time',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 15),

            // Loading Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(true),
                _buildDot(false),
                _buildDot(false),
              ],
            ),
            
            const Spacer(flex: 2),

            // Bottom Large Text
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Text(
                'GuardianGo',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF1F2937).withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.black : Colors.black26,
        shape: BoxShape.circle,
      ),
    );
  }
}