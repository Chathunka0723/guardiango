import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/parent_payment_2.dart';

class PayDriverPage extends StatefulWidget {
  const PayDriverPage({super.key});

  @override
  State<PayDriverPage> createState() => _PayDriverPageState();
}

class _PayDriverPageState extends State<PayDriverPage> {
  String selectedAmount = "\$ 20.00";
  String selectedMethod = "Credit Card";
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pay Driver",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text("Make a payment to your driver",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Driver Information Card
            _buildDriverInfoCard(),
            const SizedBox(height: 25),

            // 2. Payment Details Section
            const Text("Payment Details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 15),

            // Amount Dropdown
            _buildLabel("Amount *"),
            _buildDropdown(selectedAmount, ["\$ 10.00", "\$ 20.00", "\$ 50.00"],
                (val) {
              setState(() => selectedAmount = val!);
            }),

            const SizedBox(height: 15),

            // Payment Method Dropdown
            _buildLabel("Payment Method *"),
            _buildDropdown(
                selectedMethod, ["Credit Card", "Debit Card", "Bank Transfer"],
                (val) {
              setState(() => selectedMethod = val!);
            }),

            const SizedBox(height: 15),

            // Note Field
            _buildLabel("Note (Optional)"),
            TextField(
              controller: noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: "Add a note for the driver...",
                filled: true,
                fillColor: const Color(0xFFF9FAFB),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade200)),
              ),
            ),
            const Text("This note will be included with your payment",
                style: TextStyle(color: Colors.grey, fontSize: 10)),

            const SizedBox(height: 25),

            // 3. Billing Summary
            _buildBillingSummary(),

            const SizedBox(height: 20),

            // 4. Pay Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EnterCardDetailsPage()),
                  );
                  // payment logic
                },
                icon: const Icon(Icons.payment, color: Colors.white),
                label: Text("Pay Driver $selectedAmount",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC107), // Yellow theme
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 15),
            const Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_outline, size: 14, color: Colors.grey),
                      SizedBox(width: 5),
                      Text("Your payment is secure and encrypted",
                          style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  Text(
                      "Payments are processed securely through our payment gateway",
                      style: TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildDriverInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.person_outline, color: Colors.orange, size: 20),
              SizedBox(width: 8),
              Text("Driver Information",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 15),
          _buildInfoRow("Driver Name:", "Mike Stevens"),
          _buildInfoRow("Bus Route:", "Route A-42"),
          _buildInfoRow("Student:", "Emma Johnson"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
    );
  }

  Widget _buildDropdown(
      String value, List<String> items, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          items: items
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildBillingSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFECFDF5), // Light green background
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildSummaryRow("Subtotal:", selectedAmount),
          _buildSummaryRow("Processing Fee:", "\$0.00"),
          const Divider(),
          _buildSummaryRow("Total:", selectedAmount, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  color: isTotal ? Colors.black : Colors.grey,
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  color: isTotal ? Colors.blue : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: isTotal ? 16 : 14)),
        ],
      ),
    );
  }
}
