import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';  
import 'package:flutter/foundation.dart' show kIsWeb;

class LostAndFoundPage extends StatelessWidget {
  const LostAndFoundPage({super.key});

  Future<void> _processClaim(String itemId, String parentName) async {
    try {
      await Supabase.instance.client
          .from('lost_items')
          .update({
            'is_claimed': true,
            'claimed_by': parentName,
          })
          .eq('id', itemId);
    } catch (e) {
      debugPrint("Error claiming item: $e");
    }
  }

  void _showClaimDialog(
      BuildContext context, String itemId, String title, String location, String date) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                        onPressed: () async {
                          Navigator.pop(context);
                          final user = Supabase.instance.client.auth.currentUser;
                          String parentName = 'Parent';
                          if (user != null) {
                            try {
                              final profile = await Supabase.instance.client
                                  .from('profile')
                                  .select('full_name')
                                  .eq('profile_id', user.id)
                                  .maybeSingle();
                              if (profile != null && profile['full_name'] != null) {
                                parentName = profile['full_name'];
                              }
                            } catch (e) {
                              debugPrint("Error fetching profile: $e");
                            }
                          }
                          await _processClaim(itemId, parentName);
                          if (context.mounted) {
                            _showSuccessDialog(context, title);
                          }
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

  void _showSuccessDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Supabase.instance.client
            .from('lost_items')
            .stream(primaryKey: ['id'])
            .order('found_at', ascending: false),
        builder: (context, snapshot) {

          debugPrint("Snapshot state: ${snapshot.connectionState}");
          debugPrint("Snapshot error: ${snapshot.error}");
          debugPrint("Snapshot data: ${snapshot.data}");
          debugPrint("Data length: ${snapshot.data?.length}");

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          // ✅ FIX: Use empty list if no data, instead of returning early
          final allItems = snapshot.data ?? [];

          final availableItems =
              allItems.where((item) => item['is_claimed'] != true).toList();
          final claimedItems =
              allItems.where((item) => item['is_claimed'] == true).toList();

          // ✅ FIX: The full UI is now always returned from the builder
          return SingleChildScrollView(
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
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    suffixIcon:
                        const Icon(Icons.search, color: Colors.black87),
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
                    _buildStatusCard(
                        "Available",
                        "${availableItems.length}",
                        const Color(0xFFE8F9EE),
                        const Color(0xFF28B446),
                        Icons.layers_outlined),
                    const SizedBox(width: 16),
                    _buildStatusCard(
                        "Claimed",
                        "${claimedItems.length}",
                        Colors.white,
                        Colors.black,
                        Icons.check_circle_outline,
                        hasBorder: true),
                  ],
                ),
                const SizedBox(height: 24),

                // Available Items Section
                Row(
                  children: [
                    const Icon(Icons.inventory_2, size: 20),
                    const SizedBox(width: 8),
                    Text("Available Items (${availableItems.length})",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                if (availableItems.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("No available items found.",
                          style: TextStyle(color: Colors.grey)),
                    ),
                  )
                else
                  ...availableItems.map((item) {
                    // ✅ FIX: Safe date parsing with fallback
                    String formattedDate = 'Unknown date';
                    try {
                      formattedDate = DateFormat('MMM dd, yyyy at HH:mm')
                          .format(DateTime.parse(item['found_at']));
                    } catch (_) {}

                    return _buildLostItemCard(
                      context,
                      itemId: item['id'].toString(),
                      title: item['description'] ?? 'No Title',
                      location: item['location_found'] ?? 'Unknown',
                      date: formattedDate,
                      imagePath: item['image_url'] ?? '',
                      isClaimed: false,
                    );
                  }),

                const SizedBox(height: 24),

                // Claimed Items Section
                Row(
                  children: [
                    const Icon(Icons.check_circle, size: 20),
                    const SizedBox(width: 8),
                    Text("Claimed Items (${claimedItems.length})",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 16),
                if (claimedItems.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("No claimed items yet.",
                          style: TextStyle(color: Colors.grey)),
                    ),
                  )
                else
                  ...claimedItems.map((item) {
                    // ✅ FIX: Safe date parsing with fallback
                    String formattedDate = 'Unknown date';
                    try {
                      formattedDate = DateFormat('MMM dd, yyyy at HH:mm')
                          .format(DateTime.parse(item['found_at']));
                    } catch (_) {}

                    return _buildLostItemCard(
                      context,
                      itemId: item['id'].toString(),
                      title: item['description'] ?? 'No Title',
                      location: item['location_found'] ?? 'Unknown',
                      date: formattedDate,
                      imagePath: item['image_url'] ?? '',
                      isClaimed: true,
                      claimedBy: item['claimed_by']?.toString(),
                    );
                  }),
              ],
            ),
          );
        },
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
    String? itemId,
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
                // ✅ FIX: Show actual image if URL exists, otherwise show placeholder
                child: imagePath.isNotEmpty && Uri.parse(imagePath).isAbsolute
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: kIsWeb
                            ? Image.network(
                                imagePath,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, color: Colors.grey),
                              )
                            : CachedNetworkImage(
                                imageUrl: imagePath,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => const Icon(Icons.broken_image, color: Colors.grey),
                              ),
                      )
                    : const Icon(Icons.image, color: Colors.grey),
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
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10)),
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
                      _buildIconText(
                          Icons.verified_outlined, "By $claimedBy"),
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
                onPressed: () {
                  if (itemId != null) {
                    _showClaimDialog(
                        context, itemId, title, location, date);
                  }
                },
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
