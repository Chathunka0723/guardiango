import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            children: [
              // 1. Success Icon
              const Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Color(0xFFDCFCE7), // Light green
                  child: Icon(Icons.check_circle, color: Color(0xFF22C55E), size: 60),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Payment Successful!", 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const Text("Your payment has been processed successfully", 
                style: TextStyle(color: Colors.grey, fontSize: 13)),

              const SizedBox(height: 30),

              // 2. Transaction Details Card
              _buildTransactionCard(),

              const SizedBox(height: 20),

              // 3. Action Buttons (Download & Share)
              Row(
                children: [
                  Expanded(child: _buildOutlineBtn(Icons.download_outlined, "Download")),
                  const SizedBox(width: 15),
                  Expanded(child: _buildOutlineBtn(Icons.share_outlined, "Share")),
                ],
              ),

              const SizedBox(height: 25),

              // 4. Receipt Sent Info Box
              _buildInfoBox(),

              const SizedBox(height: 30),

              // 5. Back to Dashboard Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  icon: const Icon(Icons.home_outlined, color: Colors.white),
                  label: const Text("Back to Dashboard", 
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107), // Yellow theme
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              const Text("Need help? Contact Support", 
                style: TextStyle(color: Colors.blue, fontSize: 13, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  // ගනුදෙනු විස්තර සහිත Card එක
  Widget _buildTransactionCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFFF0FDF4),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: const Text("Transaction Details", 
              style: TextStyle(color: Color(0xFF166534), fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Text("Amount paid", style: TextStyle(color: Colors.grey, fontSize: 12)),
                const Text("\$20.00", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const Divider(height: 40),
                _buildDataRow("Transaction ID:", "TXN9831614171"),
                _buildDataRow("Payment Method:", "Credit Card"),
                _buildDataRow("Paid To:", "Mike Stevens"),
                const Divider(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Status:", style: TextStyle(color: Colors.grey)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: Color(0xFFDCFCE7), borderRadius: BorderRadius.circular(20)),
                      child: const Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green, size: 14),
                          SizedBox(width: 5),
                          Text("Completed", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildOutlineBtn(IconData icon, String label) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18, color: Colors.black),
      label: Text(label, style: const TextStyle(color: Colors.black)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // Light blue
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade100),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("📧", style: TextStyle(fontSize: 16)),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Receipt Sent", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
                Text("A payment receipt has been sent to your registered email address and the driver has been notified.", 
                  style: TextStyle(color: Color(0xFF1E3A8A), fontSize: 11)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}