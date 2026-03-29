import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; 
import 'package:guardiango_app_flutter/registration_approved_screen.dart'; 

class RegistrationSubmittedScreen extends StatefulWidget {
  final String vehicleId;

  const RegistrationSubmittedScreen({super.key, required this.vehicleId});

  @override
  State<RegistrationSubmittedScreen> createState() => _RegistrationSubmittedScreenState();
}

class _RegistrationSubmittedScreenState extends State<RegistrationSubmittedScreen> {
  void checkStatus() async {
  final supabase = Supabase.instance.client;

  final response = await supabase
      .from('profile')
      .select('status')
      .eq('profile_id', supabase.auth.currentUser!.id) 
      .single();

  if (response['status'] == 'approved') {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => RegistrationApprovedScreen(
          vehicleCode: widget.vehicleId, 
        ),
      ),
    );
  }
}

@override
void initState() {
  super.initState();
  checkStatus(); // Check immediately on load

  Future.delayed(const Duration(seconds: 5), () {
    checkStatus();
  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      body: SingleChildScrollView(
        child: Column(
          children: [

            const SizedBox(height: 80),

            // Top Icon
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
  child: Column(
    children: [
      const Text(
        "Your Vehicle ID",
        style: TextStyle(fontSize: 14, color: Colors.grey),
      ),
      const SizedBox(height: 10),
      Text(
        widget.vehicleId,
        style: const TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00C853),
        ),
      ),
    ],
  ),
),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
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