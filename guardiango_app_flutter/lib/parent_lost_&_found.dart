import 'package:flutter/material.dart';

class LostAndFoundPage extends StatelessWidget {
  const LostAndFoundPage({super.key});

  // --- Dialog 1: Confirm Claim ---
  void _showClaimDialog(
      BuildContext context, String title, String location, String date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Claim This Item?",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  "Are you sure you want to claim this item? The driver will be notified and you can arrange pickup.",
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 14),
                ),
                const SizedBox(height: 20),
                // Item Detail Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Column(
                    children: [
                      _buildDialogRow("Item:", title, isBold: true),
                      const SizedBox(height: 8),
                      _buildDialogRow("Location:", location),
                      const SizedBox(height: 8),
                      _buildDialogRow("Found:", date),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          side: const BorderSide(color: Color(0xFFE2E8F0)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Cancel",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Close Claim Dialog
                          _showSuccessDialog(context, title); // Show Success
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF28B446),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        child: const Text("Confirm Claim",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- Dialog 2: Success Notification ---
  void _showSuccessDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F9EE),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check_circle,
                      color: Color(0xFF28B446), size: 40),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Item Claimed Successfully!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Text(
                  "The driver has been notified of your claim. You can arrange pickup through the chat feature or during your next bus ride.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Item:",
                          style: TextStyle(color: Color(0xFF94A3B8))),
                      Expanded(
                        child: Text(
                          title,
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF28B446),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text("Got It",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- Helper: Dialog Rows ---
  Widget _buildDialogRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(color: Color(0xFF94A3B8), fontSize: 13)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
              color: const Color(0xFF1E293B),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Lost & Found",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text("Claim items found on the bus",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F2FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.inventory_2_outlined,
                          color: Color(0xFF3F51B5)),
                      SizedBox(width: 8),
                      Text("Lost Something?",
                          style: TextStyle(
                              color: Color(0xFF1A237E),
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Browse items found by drivers. If you see your item, click \"Claim Item\" to arrange pickup.",
                    style: TextStyle(color: Color(0xFF3F51B5), fontSize: 13),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search items by description or location",
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                suffixIcon: const Icon(Icons.search, color: Colors.black87),
                filled: true,
                fillColor: const Color(0xFFF2F0F7),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Status Counters
            Row(
              children: [
                _buildStatusCard("Available", "4", const Color(0xFFE8F9EE),
                    const Color(0xFF28B446), Icons.layers_outlined),
                const SizedBox(width: 16),
                _buildStatusCard("Claimed", "1", Colors.white, Colors.black,
                    Icons.check_circle_outline,
                    hasBorder: true),
              ],
            ),
            const SizedBox(height: 24),

            // Available Items
            Row(
              children: const [
                Icon(Icons.inventory_2, size: 20),
                SizedBox(width: 8),
                Text("Available Items (4)",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            _buildLostItemCard(
              context,
              title: "Black backpack with unicorn keychain",
              location: "Under seat 12, back of bus",
              date: "Jan 26, 2026 at 8:15",
              imagePath: 'assets/backpack.png',
              isClaimed: false,
            ),
            _buildLostItemCard(
              context,
              title: "Pink water bottle with stickers",
              location: "Front seat area",
              date: "Jan 25, 2026 at 15:30",
              imagePath: 'assets/bottle.png',
              isClaimed: false,
            ),

            const SizedBox(height: 24),

            // Claimed Items
            Row(
              children: const [
                Icon(Icons.check_circle, size: 20),
                SizedBox(width: 8),
                Text("Claimed Items (1)",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 16),
            _buildLostItemCard(
              context,
              title: "Yellow notebook",
              location: "Seat 5",
              date: "Jan 23, 2026 at 08:30",
              imagePath: 'assets/notebook.png',
              isClaimed: true,
              claimedBy: "Sarah Johnson",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard(
      String label, String count, Color bgColor, Color textColor, IconData icon,
      {bool hasBorder = false}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: hasBorder ? Border.all(color: Colors.grey.shade300) : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: textColor.withOpacity(0.7), fontSize: 12)),
                Text(count,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Icon(icon, color: textColor.withOpacity(0.3), size: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLostItemCard(
    BuildContext context, {
    required String title,
    required String location,
    required String date,
    required String imagePath,
    required bool isClaimed,
    String? claimedBy,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isClaimed ? const Color(0xFFF1F5F9) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image, color: Colors.grey),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (isClaimed)
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text("Claimed",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10)),
                        ),
                      ),
                    Text(title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 8),
                    _buildIconText(
                        Icons.location_on_outlined, "Found: $location"),
                    const SizedBox(height: 4),
                    _buildIconText(Icons.calendar_today_outlined, date),
                    if (isClaimed && claimedBy != null) ...[
                      const SizedBox(height: 4),
                      _buildIconText(Icons.verified_outlined, "By $claimedBy"),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (!isClaimed) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton.icon(
                onPressed: () =>
                    _showClaimDialog(context, title, location, date),
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text("Claim Item"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF28B446),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey),
        const SizedBox(width: 4),
        Expanded(
          child: Text(text,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
