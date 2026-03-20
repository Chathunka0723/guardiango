import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/parent_chat.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:guardiango_app_flutter/parent_emergency_contacts.dart';

class FeedbackRatingsPage extends StatefulWidget {
  const FeedbackRatingsPage({super.key});

  @override
  State<FeedbackRatingsPage> createState() => _FeedbackRatingsPageState();
}

class _FeedbackRatingsPageState extends State<FeedbackRatingsPage> {
  int _rating = 0;
  String? _dropdownValue;
  XFile? _pickedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image != null) {
      setState(() {
        _pickedImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Feedback & Ratings",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text("Help us improve your experience",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                _buildTypeCard("Suggestion", Icons.lightbulb_outline,
                    Colors.blue, "Feature Suggestion"),
                const SizedBox(width: 12),
                _buildTypeCard("Bug Report", Icons.bug_report_outlined,
                    Colors.red, "Bug Report"),
                const SizedBox(width: 12),
                _buildTypeCard("General", Icons.chat_bubble_outline,
                    Colors.green, "General Feedback"),
              ],
            ),
            const SizedBox(height: 20),
            _buildCard(
              child: Column(
                children: [
                  const Text("Rate Your Experience",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  const Text("How would you rate the School Bus Tracker app?",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        onPressed: () => setState(() => _rating = index + 1),
                        icon: Icon(
                          index < _rating ? Icons.star : Icons.star_border,
                          color: index < _rating
                              ? Colors.amber
                              : Colors.grey.shade400,
                          size: 32,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Tell Us More",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 20),
                  const Text("Category",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 8),
                  _buildDropdown(),
                  const SizedBox(height: 20),
                  const Text("Your Feedback",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: "Please share your thoughts...",
                      hintStyle:
                          TextStyle(color: Colors.grey.shade500, fontSize: 13),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_pickedImage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: kIsWeb
                            ? Image.network(_pickedImage!.path,
                                height: 100, width: 100, fit: BoxFit.cover)
                            : Image.file(File(_pickedImage!.path),
                                height: 100, width: 100, fit: BoxFit.cover),
                      ),
                    ),
                  _buildOutlineButton(
                    context,
                    _pickedImage != null
                        ? Icons.check_circle
                        : Icons.camera_alt_outlined,
                    _pickedImage != null
                        ? "Image Attached"
                        : "Attach Screenshot (Optional)",
                    onTap: _pickImage,
                  ),
                  const SizedBox(height: 16),
                  _buildSubmitButton(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _buildEmergencyCard(context),
            const SizedBox(height: 16),
            _buildOutlineButton(context, Icons.chat_bubble_outline,
                "Check Frequently Asked Questions", isFullWidth: true,
                onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ParentEmergencyContact(scrollToFaq: true),
                ),
              );
            }),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeCard(
      String label, IconData icon, Color color, String dropdownMatch) {
    bool isSelected = _dropdownValue == dropdownMatch;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _dropdownValue = dropdownMatch),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: isSelected ? color : Colors.grey.shade200, width: 2),
          ),
          child: Column(
            children: [
              Icon(icon, color: isSelected ? color : Colors.grey),
              const SizedBox(height: 8),
              Text(label,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: isSelected ? color : Colors.black87)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: child,
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _dropdownValue,
          hint: Text("Select feedback type",
              style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
          isExpanded: true,
          items: [
            "General Feedback",
            "Bug Report",
            "Feature Suggestion",
            "Driver Feedback",
            "App Performance",
            "Other"
          ]
              .map((String value) => DropdownMenuItem(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 14))))
              .toList(),
          onChanged: (val) => setState(() => _dropdownValue = val),
        ),
      ),
    );
  }

  Widget _buildOutlineButton(BuildContext context, IconData icon, String label,
      {bool isFullWidth = true, VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: isFullWidth ? double.infinity : null,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: Colors.black87),
              const SizedBox(width: 8),
              Text(label,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.send, size: 18),
        label: const Text("Submit Feedback",
            style: TextStyle(fontWeight: FontWeight.bold)),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1D61FF),
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildEmergencyCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD0E8FF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Need Immediate Help?",
              style: TextStyle(
                  color: Color(0xFF004BA0),
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
          const SizedBox(height: 8),
          const Text(
            "For urgent issues related to your child's safety, please contact our team.",
            style: TextStyle(color: Color(0xFF4A86CC), fontSize: 12),
          ),
          const SizedBox(height: 16),
          _buildOutlineButton(
            context,
            Icons.phone_outlined,
            "Emergency Contacts",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ParentEmergencyContact(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
