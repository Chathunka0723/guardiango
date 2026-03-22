import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DriverRegistrationPage2 extends StatefulWidget {
  final PageController pageController;
  final Function(Map<String, dynamic> vehicleData) onNext; 

  const DriverRegistrationPage2({super.key, required this.pageController, required this.onNext});

  @override
  State<DriverRegistrationPage2> createState() => _DriverRegistrationPage2State();
}

class _DriverRegistrationPage2State extends State<DriverRegistrationPage2> {
  // Vehicle Photos (Multiple images selection)
  List<File> _vehicleImages = [];
  final _picker = ImagePicker();

  // Input Controllers
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _plateNumberController = TextEditingController();
  final _seatsController = TextEditingController();
  final _otherFeaturesController = TextEditingController();

  bool _isACEnabled = false;

  // බස් එකේ පින්තූර කිහිපයක් තෝරාගැනීමට
  Future<void> _pickMultipleImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _vehicleImages = pickedFiles.map((file) => File(file.path)).toList();
      });
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
            _buildHeader(),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // --- Vehicle Photos Section ---
                  _buildSectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.directions_bus_outlined, size: 20),
                            SizedBox(width: 8),
                            Text("Vehicle Photos", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text("Upload clear photos of your bus (exterior and interior)",
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                        const SizedBox(height: 20),
                        _buildImageUploadArea(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Vehicle Information Form ---
                  _buildSectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Vehicle Information", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 20),
                        _buildLabel("Vehicle Model"),
                        _buildTextField(_modelController, "e.g., Nissan Civilian", null),
                        const SizedBox(height: 15),
                        _buildLabel("Vehicle Year"),
                        _buildTextField(_yearController, "e.g., 2020", Icons.calendar_month_outlined),
                        const SizedBox(height: 15),
                        _buildLabel("Vehicle Plate Number"),
                        _buildTextField(_plateNumberController, "e.g., ABC-1234", Icons.tag),
                        const SizedBox(height: 15),
                        _buildLabel("Number of Seats"),
                        _buildTextField(_seatsController, "e.g., 45", Icons.person_outline),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Vehicle Features Section ---
                  _buildSectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Vehicle Features", style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text("Air Conditioning", style: TextStyle(fontSize: 14)),
                          value: _isACEnabled,
                          activeColor: const Color(0xFF00C853),
                          onChanged: (val) => setState(() => _isACEnabled = val!),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        const SizedBox(height: 10),
                        const Text("Other", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 8),
                        _buildTextField(_otherFeaturesController, "Add your Vehicle Features", null),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),

                  // --- Navigation Buttons ---
                  _buildActionButtons(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Helper Methods ---

  Widget _buildHeader() {
    return Container(
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
            onPressed: () => widget.pageController.previousPage(
                duration: const Duration(milliseconds: 300), curve: Curves.ease),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Vehicle Details",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("Step 2: Bus Information", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  _buildStepMarker(Icons.check, isCompleted: true),
                  _buildStepNumber("2", isActive: true),
                  _buildStepNumber("3"),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadArea() {
    return InkWell(
      onTap: _pickMultipleImages,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: _vehicleImages.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.upload_outlined, color: Colors.grey),
                  SizedBox(height: 8),
                  Text("Upload Vehicle Photos", style: TextStyle(fontSize: 13, color: Colors.grey)),
                  Text("Click to select multiple images", style: TextStyle(fontSize: 11, color: Colors.grey)),
                ],
              )
            : GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
                itemCount: _vehicleImages.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(_vehicleImages[index], fit: BoxFit.cover),
                  );
                },
              ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
onPressed: () {
  widget.onNext({
    'vehicle_model': _modelController.text,
    'vehicle_number': _plateNumberController.text,
    'seats': _seatsController.text,
  });

  widget.pageController.nextPage(
    duration: const Duration(milliseconds: 300),
    curve: Curves.ease,
  );
}
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00C853),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text("Continue to Route Details", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  // --- Shared Reusable Widgets (Page 1 වගේමයි) ---
  Widget _buildStepNumber(String number, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 28, height: 28,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white24,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(number,
            style: TextStyle(
                color: isActive ? const Color(0xFF00C853) : Colors.white70,
                fontSize: 12, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStepMarker(IconData icon, {bool isCompleted = false}) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 28, height: 28,
      decoration: BoxDecoration(
        color: isCompleted ? Colors.white : Colors.white24,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: const Color(0xFF00C853), size: 16),
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
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
          children: const [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData? icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: icon != null ? Icon(icon, color: Colors.grey, size: 20) : null,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }
}