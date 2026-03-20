import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PostLostItemScreen extends StatefulWidget {
  const PostLostItemScreen({super.key});

  @override
  State<PostLostItemScreen> createState() => _PostLostItemScreenState();
}

class _PostLostItemScreenState extends State<PostLostItemScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final _picker = ImagePicker();
  XFile? _selectedImage;
  bool _isLoading = false;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  // Date Picker Logic
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  Future<String?> _uploadImage() async {
    if (_selectedImage == null) return null;

    try {
      final fileName = const Uuid().v4();
      final String originalName = _selectedImage!.name;
      String fileExtension = 'jpg';
      if (originalName.contains('.')) {
        fileExtension = originalName.split('.').last;
      }
      final path = '$fileName.$fileExtension';

      final fileBytes = await _selectedImage!.readAsBytes();
      await Supabase.instance.client.storage
          .from('lost_item_images')
          .uploadBinary(path, fileBytes);

      final String imageUrl = Supabase.instance.client.storage
          .from('lost_item_images')
          .getPublicUrl(path);

      return imageUrl;
    } catch (e) {
      debugPrint("Error uploading image: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to upload image: $e')));
      }
      return null;
    }
  }

  Future<void> _postItem() async {
    if (_descriptionController.text.isEmpty || _locationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // දින සහ වෙලාව එකතු කරලා String එකක් හදාගමු
      final DateTime finalDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      // 1. Submit the image completely
      final imageUrl = await _uploadImage();

      // පින්තූරය තෝරා දී තිබියදීත් upload එක අසාර්ථක වූවාදැයි පරීක්ෂා කිරීම
      if (_selectedImage != null && imageUrl == null) {
        debugPrint("Image upload failed, stopping database insert.");
        if (mounted) setState(() => _isLoading = false);
        return; // මෙතනින් නවතින්න, දත්තබේස් එකට යවන්න එපා!
      }

      // 2. ඩේටාබේස් එකට දත්ත ඇතුළත් කිරීම
      await Supabase.instance.client.from('lost_items').insert({
        'bus_id': 'BUS-NC-0001', // Placeholder or actual Bus ID
        'description': _descriptionController.text,
        'location_found': _locationController.text,
        'found_at': finalDateTime.toIso8601String(),
        'image_url': imageUrl, 
        'is_claimed': false,
      });
      
      debugPrint("Database Insert Success!");

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Item posted successfully! Parents notified.")),
        );
        Navigator.pop(context); // සාර්ථක වුණාම කලින් පේජ් එකට යමු
      }
    } catch (e) {
      debugPrint("DATABASE ERROR: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error posting item: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // Time Picker Logic
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() => _selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        leading: const BackButton(),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Post Lost Item", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Report a found item", style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.phone_outlined))],
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ), // Fixed syntax error here: was ], instead of ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Blue Info Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0FE),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.inventory_2_outlined, color: Color(0xFF3F51B5)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Lost Something?", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                        SizedBox(height: 4),
                        Text(
                          "Help reunite lost items with their owners by posting details here. Parents will be able to view and claim items.",
                          style: TextStyle(fontSize: 12, color: Color(0xFF3F51B5)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Main Form Container
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Item Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  
                  // Image Upload Placeholder
                  const Text("Item Photo", style: TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
      child: _selectedImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: kIsWeb
                  ? Image.network(_selectedImage!.path, fit: BoxFit.cover)
                  : Image.file(File(_selectedImage!.path), fit: BoxFit.cover),
            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.upload_outlined, color: Colors.grey[400], size: 30),
                                const SizedBox(height: 8),
                                const Text("Upload Photo", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text("Click to select an image", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text("A clear photo helps parents identify their items", style: TextStyle(color: Colors.grey[500], fontSize: 11)),
                  
                  const SizedBox(height: 20),
                  _buildLabel("Item Description"),
                  _buildTextField(_descriptionController, "e.g., Blue pencil case..."),
                  
                  const SizedBox(height: 20),
                  _buildLabel("Location Found"),
                  _buildTextField(_locationController, "e.g., Under seat 12, back of bus..."),
                  
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Date Found"),
                            InkWell(
                              onTap: () => _selectDate(context),
                              child: _buildDateTimePicker(DateFormat('dd/MM/yyyy').format(_selectedDate), Icons.calendar_today_outlined),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Time Found"),
                            InkWell(
                              onTap: () => _selectTime(context),
                              child: _buildDateTimePicker(_selectedTime.format(context), Icons.access_time),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _postItem,
                        icon: _isLoading 
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                            : const Icon(Icons.upload_outlined),
                        label: Text(_isLoading ? "Posting..." : "Post Lost Item", 
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF38CC62),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: RichText(
        text: TextSpan(
          text: text,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          children: const [TextSpan(text: ' *', style: TextStyle(color: Colors.red))],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildDateTimePicker(String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 10),
          Text(value, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}