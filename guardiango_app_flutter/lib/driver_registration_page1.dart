import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // image picker package එක add කරගන්න
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class DriverRegistrationPage1 extends StatefulWidget {
  final PageController pageController; // PageView එක handle කිරීමට

  const DriverRegistrationPage1({super.key, required this.pageController});

  @override
  State<DriverRegistrationPage1> createState() => _DriverRegistrationPage1State();
}

class _DriverRegistrationPage1State extends State<DriverRegistrationPage1> {
  // Image Storage සඳහා variables
  XFile? _profileImage;
  XFile? _licenseFrontImage;
  XFile? _licenseBackImage;

  final _picker = ImagePicker();

  // Input Controllers
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  // පින්තූරයක් තෝරාගැනීමේ function එක
  Future<void> _pickImage(String type) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      setState(() {
        if (type == 'profile') _profileImage = pickedFile;
        if (type == 'front') _licenseFrontImage = pickedFile;
        if (type == 'back') _licenseBackImage = pickedFile;
      });
    }
  }

  Future<void> _saveAndContinue() async {
    if (_fullNameController.text.isEmpty || _emailController.text.isEmpty || _phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all required fields")));
      return;
    }

    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator(color: Color(0xFF00C853))),
      );

      final supabase = Supabase.instance.client;

      final AuthResponse res = await supabase.auth.signUp(
        email: _emailController.text.trim(),
        password: _phoneController.text.trim(),
      );

      final String? userId = res.user?.id;
      if (userId == null) {
        throw Exception("Failed to create user account.");
      }

      String? profileUrl = await _uploadToStorage(_profileImage, 'profiles/$userId.jpg');
      String? licenseFrontUrl = await _uploadToStorage(_licenseFrontImage, 'license/$userId-front.jpg');
      String? licenseBackUrl = await _uploadToStorage(_licenseBackImage, 'license/$userId-back.jpg');

      await supabase.from('profiles').upsert({
        'id': userId,
        'full_name': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone_number': _phoneController.text.trim(),
        'profile_photo': profileUrl,
        'license_front': licenseFrontUrl,
        'license_back': licenseBackUrl,
        'role': 'driver',
      });

      if (mounted) {
        Navigator.pop(context);
        widget.pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  Future<String?> _uploadToStorage(XFile? file, String path) async {
    if (file == null) return null;
    try {
      final supabase = Supabase.instance.client;
      final fileBytes = await file.readAsBytes();
      await supabase.storage.from('driver-documents').uploadBinary(path, fileBytes, fileOptions: const FileOptions(contentType: 'image/jpeg'));
      return supabase.storage.from('driver-documents').getPublicUrl(path);
    } catch (e) {
      debugPrint("Storage Upload Error: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Green Gradient Header ---
            Container(
              width: double.infinity,
              height: 150,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00C853), Color(0xFF00E676)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Create Driver Account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          Text("Step 1: Personal Details",
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                      // Numbered Steps (1, 2, 3)
                      Row(
                        children: [
                          _buildStepNumber("1", isActive: true),
                          _buildStepNumber("2"),
                          _buildStepNumber("3"),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // --- Main Content Area ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // --- Profile Photo Box ---
                  _buildFormContainer(
                    child: Column(
                      children: [
                        const Text("Profile Photo",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: _profileImage != null
                              ? (kIsWeb ? NetworkImage(_profileImage!.path) : FileImage(File(_profileImage!.path))) as ImageProvider
                              : null,
                          child: _profileImage == null
                              ? const Icon(Icons.person,
                                  size: 40, color: Colors.grey)
                              : null,
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: () => _pickImage('profile'),
                          icon: const Icon(Icons.camera_alt_outlined, size: 18, color: Colors.black),
                          label: const Text("Upload Photo", style: TextStyle(color: Colors.black)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Personal Information Form ---
                  _buildFormContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Personal Information",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        _buildLabel("Full Name"),
                        _buildTextField(_fullNameController, "Enter your full name", Icons.person_outline),
                        const SizedBox(height: 15),
                        _buildLabel("Email Address"),
                        _buildTextField(_emailController, "your.email@example.com", Icons.email_outlined),
                        const SizedBox(height: 15),
                        _buildLabel("Phone Number"),
                        _buildTextField(_phoneController, "+94 XXX XXX XXX", Icons.phone_outlined),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Driver's License Section ---
                  _buildFormContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.badge_outlined, size: 20),
                            SizedBox(width: 8),
                            Text("Driver's License",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Upload clear photos of both sides of your driver's license",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 20),
                        _buildLabel("Front Side"),
                        _buildImageUploadBox(_licenseFrontImage, () => _pickImage('front')),
                        const SizedBox(height: 15),
                        _buildLabel("Back Side"),
                        _buildImageUploadBox(_licenseBackImage, () => _pickImage('back')),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- Continue Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _saveAndContinue,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C853),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Continue to Vehicle Details", style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets (Kalin code eka wage) ---
  Widget _buildStepNumber(String number, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white24,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(number,
            style: TextStyle(
                color: isActive ? const Color(0xFF00C853) : Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildFormContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      child: child,
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),
          children: const [
            TextSpan(text: ' *', style: TextStyle(color: Colors.red))
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey, size: 20),
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildImageUploadBox(XFile? image, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          image: image != null
              ? DecorationImage(
                  image: (kIsWeb ? NetworkImage(image.path) : FileImage(File(image.path))) as ImageProvider, 
                  fit: BoxFit.cover)
              : null,
        ),
        child: image == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload_file, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("Upload Image", style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text("Click to select image", style: TextStyle(fontSize: 10, color: Colors.grey)),
                ],
              )
            : null,
      ),
    );
  }
}