import 'package:flutter/material.dart';

class DriverRegistrationPage3 extends StatefulWidget {
  final PageController pageController;
  final VoidCallback onSubmit; // අවසාන පියවර නිසා Submit function එකක් ඕනෙ වෙනවා

  const DriverRegistrationPage3({
    super.key, 
    required this.pageController, 
    required this.onSubmit
  });

  @override
  State<DriverRegistrationPage3> createState() => _DriverRegistrationPage3State();
}

class _DriverRegistrationPage3State extends State<DriverRegistrationPage3> {
  // Starting Point Controllers
  final _startingCityController = TextEditingController();
  TimeOfDay? _departureTime;

  // Route Stops සඳහා List එකක් (Dynamic විදියට Stops එකතු කරන්න)
  List<Map<String, dynamic>> _stops = [
    {'city': TextEditingController(), 'school': TextEditingController(), 'arrival': null}
  ];

  // Time Picker එක පෙන්වීමට
  Future<void> _selectTime(BuildContext context, int? index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (index == null) {
          _departureTime = picked;
        } else {
          _stops[index]['arrival'] = picked;
        }
      });
    }
  }

  // අලුත් Stop එකක් එකතු කිරීම
  void _addStop() {
    setState(() {
      _stops.add({'city': TextEditingController(), 'school': TextEditingController(), 'arrival': null});
    });
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

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // --- Starting Point Section ---
                  _buildSectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: Colors.green),
                            SizedBox(width: 8),
                            Text("Starting Point", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        _buildLabel("Starting City"),
                        _buildTextField(_startingCityController, "e.g., Downtown Terminal"),
                        const SizedBox(height: 15),
                        _buildLabel("Departure Time"),
                        _buildTimePickerTile(
                          _departureTime?.format(context) ?? "Select Time",
                          () => _selectTime(context, null),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Route Stops & Schools Section ---
                  _buildSectionContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Route Stops & Schools", style: TextStyle(fontWeight: FontWeight.bold)),
                            OutlinedButton.icon(
                              onPressed: _addStop,
                              icon: const Icon(Icons.add, size: 16, color: Colors.green),
                              label: const Text("Add Stop", style: TextStyle(color: Colors.green, fontSize: 12)),
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.green),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        
                        // Dynamic Stops List
                        ...List.generate(_stops.length, (index) => _buildStopItem(index)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Review Info Banner ---
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F9EE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      "Review your information: Once submitted, your registration will be reviewed by our team. You'll receive a notification once approved.",
                      style: TextStyle(fontSize: 12, color: Color(0xFF2E7D32)),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // --- Submit Button ---
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: widget.onSubmit, // Final submission call
                      icon: const Icon(Icons.send_outlined, size: 18),
                      label: const Text("Submit Registration", style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C853),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
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

  // --- UI Helper Methods ---

  Widget _buildStopItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.blue,
              child: Text("${index + 1}", style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
            const SizedBox(width: 10),
            Text("Stop ${index + 1}", style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
        const SizedBox(height: 15),
        _buildLabel("City/Location"),
        _buildTextField(_stops[index]['city'], "e.g., Maple Avenue"),
        const SizedBox(height: 15),
        _buildLabel("School Name"),
        _buildTextField(_stops[index]['school'], "e.g., Lincoln Elementary School"),
        const SizedBox(height: 15),
        _buildLabel("Arrival Time"),
        _buildTimePickerTile(
          _stops[index]['arrival']?.format(context) ?? "Select Time",
          () => _selectTime(context, index),
        ),
        const Divider(height: 40),
      ],
    );
  }

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
                  Text("Route Details",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Text("Step 3: Route Information", style: TextStyle(color: Colors.white70, fontSize: 12)),
                ],
              ),
              Row(
                children: [
                  _buildStepMarker(Icons.check, isCompleted: true),
                  _buildStepMarker(Icons.check, isCompleted: true),
                  _buildStepNumber("3", isActive: true),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // --- Shared Reusable UI Components ---
  Widget _buildStepNumber(String number, {bool isActive = false}) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 28, height: 28,
      decoration: BoxDecoration(color: isActive ? Colors.white : Colors.white24, shape: BoxShape.circle),
      child: Center(child: Text(number, style: TextStyle(color: isActive ? Colors.green : Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildStepMarker(IconData icon, {bool isCompleted = false}) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      width: 28, height: 28,
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.green, size: 16),
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))]),
      child: child,
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text + "*", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: const Color(0xFFF5F5F5),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildTimePickerTile(String time, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            const Icon(Icons.access_time, color: Colors.grey, size: 20),
            const SizedBox(width: 10),
            Text(time, style: const TextStyle(color: Colors.grey, fontSize: 13)),
            const Spacer(),
            const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
} 