import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/parent_payment_3.dart'; // Assuming this is your success page

class EnterCardDetailsPage extends StatefulWidget {
  final String amount;
  final String driverName;

  const EnterCardDetailsPage(
      {super.key, this.amount = "\$20.00", this.driverName = "Mike Stevens"});

  @override
  State<EnterCardDetailsPage> createState() => _EnterCardDetailsPageState();
}

class _EnterCardDetailsPageState extends State<EnterCardDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Enter Card Details",
                style: TextStyle(
                    color: Color(0xFF1E293B),
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text("Complete your payment securely",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // 1. Amount Summary Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF), // Light blue
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFDBEAFE)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Payment Amount:",
                          style: TextStyle(
                              color: Color(0xFF64748B), fontSize: 13)),
                      const SizedBox(height: 12),
                      const Text("Driver:",
                          style: TextStyle(
                              color: Color(0xFF64748B), fontSize: 13)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(widget.amount,
                          style: const TextStyle(
                              color: Color(0xFF2563EB),
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(widget.driverName,
                          style: const TextStyle(
                              color: Color(0xFF1E293B),
                              fontSize: 14,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. Card Information Form
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.credit_card,
                          color: Color(0xFF2563EB), size: 20),
                      SizedBox(width: 8),
                      Text("Card Information",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  _buildLabel("Cardholder Name"),
                  _buildTextField("John Smith"),

                  const SizedBox(height: 16),

                  _buildLabel("Card Number"),
                  _buildTextField("1234 5678 9012 3456",
                      suffixIcon: Icons.credit_card),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Expiry Date"),
                            _buildTextField("MM/YY"),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("CVV"),
                            _buildTextField("123"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // CVV Info Box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade100),
                    ),
                    child: const Text(
                      "CVV: The 3 or 4 digit security code on the back of your card",
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 11),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 3. Secure Processing Info
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF0FDF4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFDCFCE7)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.verified_user_outlined,
                      color: Color(0xFF166534), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Secure Payment Processing",
                            style: TextStyle(
                                color: Color(0xFF166534),
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                        const SizedBox(height: 4),
                        Text(
                          "Your payment information is encrypted and processed securely. We use industry-standard SSL encryption to protect your card details. Your information will never be shared with third parties.",
                          style: TextStyle(
                              color: Colors.green.shade800,
                              fontSize: 11,
                              height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 4. Confirm Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PaymentSuccessPage()),
                  );
                },
                icon: const Icon(Icons.lock_outline,
                    color: Colors.white, size: 20),
                label: Text("Confirm Payment ${widget.amount}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D4ED8), // Deep blue
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 5. Footer Info
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.lock, size: 14, color: Colors.grey.shade400),
                    const SizedBox(width: 5),
                    Text("256-bit SSL Encryption",
                        style: TextStyle(
                            color: Colors.grey.shade500, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text("Your card details are never stored on our servers",
                    style:
                        TextStyle(color: Colors.grey.shade500, fontSize: 11)),
              ],
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
          style: const TextStyle(
              color: Color(0xFF1E293B),
              fontWeight: FontWeight.bold,
              fontSize: 13),
          children: const [
            TextSpan(text: " *", style: TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {IconData? suffixIcon}) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFF1F5F9),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: Colors.grey.shade400)
            : null,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
      ),
    );
  }
}
