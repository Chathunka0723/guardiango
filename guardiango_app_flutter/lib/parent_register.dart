import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Ensure this is imported
import 'package:guardiango_app_flutter/parent_search_transport.dart';

class CreateParentAccountPage extends StatefulWidget {
  const CreateParentAccountPage({super.key});

  @override
  State<CreateParentAccountPage> createState() =>
      _CreateParentAccountPageState();
}

class _CreateParentAccountPageState extends State<CreateParentAccountPage> {
  // 1. Text Controllers to capture input for your Notification/Auth backend
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  // 2. Logic to trigger OTP and send Metadata to your SQL Trigger
  Future<void> _handleRegistration() async {
    if (_phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter phone number")));
      return;
    }

    setState(() => _isLoading = true);
    try {
      await Supabase.instance.client.auth.signInWithOtp(
        phone: _phoneController.text.trim(),
        data: {
          'full_name': _nameController.text.trim(),
          'role': 'PARENT', // Matches your backend profile role
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("OTP Sent! Check your messages.")),
        );
        // Navigate to your OTP Verification page here
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6D5B8),
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
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        "GuardianGo",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
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
                          offset: const Offset(0, 5)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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

                      // Input Fields linked to controllers
                      buildTextField(
                          "Full Name", "Enter your name", _nameController),
                      buildTextField("Email Address", "Enter your email",
                          _emailController),
                      buildTextField("Phone Number", "Enter your Phone Number",
                          _phoneController),

                      buildDropdown("Pickup Location"),
                      buildDropdown("School"),

                      buildTextField("Password", "Create a Password", null,
                          isPassword: true),
                      buildTextField(
                          "Confirm Password", "Confirm your Password", null,
                          isPassword: true),

                      const SizedBox(height: 20),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: _isLoading ? null : _handleRegistration,
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.black)
                              : const Text(
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
                              onTap: () => Navigator.pop(context),
                              child: const Text(
                                "Log In",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold),
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

  // UPDATED: Added controller parameter to buildTextField
  Widget buildTextField(
      String label, String hint, TextEditingController? controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          TextField(
            controller: controller, // Links UI to Backend logic
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

  Widget buildDropdown(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
            ),
            items: const [
              DropdownMenuItem(value: "Option1", child: Text("Option 1")),
              DropdownMenuItem(value: "Option2", child: Text("Option 2")),
            ],
            onChanged: (value) {},
            hint: Text("Select $label"),
          ),
        ],
      ),
    );
  }
}
