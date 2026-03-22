import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/parent_search_transport.dart';

class CreateParentAccountPage extends StatefulWidget {
  const CreateParentAccountPage({super.key});

class CreateParentAccountPage extends StatefulWidget {
  const CreateParentAccountPage({super.key});

  @override
  State<CreateParentAccountPage> createState() => _CreateParentAccountPageState();
}

class _CreateParentAccountPageState extends State<CreateParentAccountPage> {
  // 1. Define Controllers
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  // Add others as needed...

  bool _isLoading = false;

  // 2. The Logic Function
  Future<void> _handleRegistration() async {
    setState(() => _isLoading = true);
    try {
      await Supabase.instance.client.auth.signInWithOtp(
        phone: _phoneController.text.trim(),
        data: {
          'full_name': _nameController.text.trim(),
          'role': 'PARENT', // Telling your SQL Trigger this is a Parent
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP Sent to your phone!")),
        );
        // Navigate to your OTP Verification Screen here
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  // ... rest of your build method ...
}

  @override
  Widget build(BuildContext context) {
    buildTextField("Full Name", "Enter your name", _nameController),
    buildTextField("Email Address", "Enter your email", _emailController),
    buildTextField("Phone Number", "Enter your Phone Number", _phoneController),
    
    // Update the "Create Account" Button
    onPressed: _isLoading ? null : _handleRegistration,
    child: _isLoading 
    ? const CircularProgressIndicator(color: Colors.black) 
    : const Text("Create Account"),

    return Scaffold(
      backgroundColor: const Color(0xFFE6D5B8), // background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Top Bar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "GuardianGo",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48)
                ],
              ),

              const SizedBox(height: 10),

              // Card Container
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Center(
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      const Center(
                        child: Text(
                          "Join thousands of parents tracking their children safely",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ),

                      const SizedBox(height: 20),

                      buildTextField("Full Name", "Enter your name"),
                      buildTextField("Email Address", "Enter your email"),
                      buildTextField("Phone Number", "Enter your Phone Number"),

                      buildDropdown("Pickup Location"),
                      buildDropdown("School"),

                      buildTextField("Password", "Create a Password",
                          isPassword: true),
                      buildTextField("Confirm Password", "Confirm your Password",
                          isPassword: true),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LocationSelectionScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Create Account",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Log In",
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold,
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
            ],
          ),
        ),
      ),
    );
  }

  // TextField Widget
  Widget buildTextField(String label, String hint,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          TextField(
            controller: controller,
            obscureText: isPassword,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dropdown Widget
  Widget buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
            items: const [
              DropdownMenuItem(
                value: "Option1",
                child: Text("Option 1"),
              ),
              DropdownMenuItem(
                value: "Option2",
                child: Text("Option 2"),
              ),
            ],
            onChanged: (value) {},
            hint: Text("Select $label"),
          ),
        ],
      ),
    );
  }
}