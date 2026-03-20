import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/parent_route_map.dart';

class TransportDetailsPage extends StatelessWidget {
  const TransportDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 1. Header with Gradient
          _buildHeader(context),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // 2. Bus Image Section
                  _buildImageCarousel(),

                  const SizedBox(height: 20),
                  // 3. Rating Card
                  _buildRatingCard(),

                  const SizedBox(height: 16),
                  // 4. Driver Card
                  _buildDriverCard(),

                  const SizedBox(height: 24),

                  // 5. Vehicle Info List
                  _buildVehicleInfo(),

                  const SizedBox(height: 24),

                  // 6. Features & Contact Section (Unified)
                  _buildFeaturesSection(context),

                  const SizedBox(height: 24),
                  const Text("Route Plan",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  // 7. Vertical Timeline
                  _buildRoutePlan(),

                  const SizedBox(height: 24),
                  const Text("Reviews",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 12),
                  // 8. Review List
                  _buildReviewList(),

                  const SizedBox(height: 20),
                  // 9. Bottom Actions
                  _buildActionButton(
                    context,
                    "View Route Map",
                    Colors.white,
                    Colors.black,
                    border: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TransportDetailsUI()),
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  _buildActionButton(context, "Select This Transport",
                      const Color(0xFFFFC107), Colors.black, onTap: () {
                    print("Transport Seleceted");
                  }),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 50, bottom: 20, left: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFFD54F), Color(0xFFFB8C00)],
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Transport Details",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              Text("Complete route information",
                  style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset('assets/school_bus.jpg',
              height: 200, width: double.infinity, fit: BoxFit.cover),
        ),
        const Positioned(
          left: 10,
          top: 90,
          child: CircleAvatar(
              backgroundColor: Colors.white70,
              radius: 15,
              child: Icon(Icons.chevron_left, size: 20)),
        ),
        const Positioned(
          right: 10,
          top: 90,
          child: CircleAvatar(
              backgroundColor: Colors.white70,
              radius: 15,
              child: Icon(Icons.chevron_right, size: 20)),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.circular(4)),
            child: const Text("Route A-101",
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star, color: Colors.amber, size: 24),
              Icon(Icons.star_border, color: Colors.amber, size: 24),
            ],
          ),
          SizedBox(height: 8),
          Text("4.8",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text("Based on 225 reviews",
              style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildDriverCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.amber.shade100, shape: BoxShape.circle),
            child: const Icon(Icons.person, color: Colors.orange),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Driver Name",
                  style: TextStyle(color: Colors.black, fontSize: 12)),
              Text("Sampath", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildVehicleInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Vehicle Information",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          _infoRow(Icons.tag, "Vehicle Model", "Blue Bird Vision 2022",
              const Color(0xFFE3F2FD), Colors.blue),
          const Divider(height: 24, thickness: 0.8),
          _infoRow(Icons.badge_outlined, "Vehicle ID", "VH -42 - 2020",
              const Color(0xFFF3E5F5), Colors.purple),
          const Divider(height: 24, thickness: 0.8),
          _infoRow(Icons.tag, "Vehicle Number", "#42", const Color(0xFFE8F5E9),
              Colors.green),
          const Divider(height: 24, thickness: 0.8),
          _infoRow(Icons.phone_outlined, "Contact Number", "077 2564892",
              const Color(0xFFFFF3E0), Colors.orange),
        ],
      ),
    );
  }

  Widget _infoRow(
      IconData icon, String title, String value, Color bg, Color iconColor) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Features & Availability",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _featureBox(
                  "Seat Availability",
                  "5",
                  "Seats Available",
                  const Color(0xFFE8F5E9),
                  const Color(0xFF2E7D32),
                  icon: Icons.groups_outlined,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _featureBox(
                  "Air Conditioning",
                  "",
                  "",
                  const Color(0xFFE3F2FD),
                  const Color(0xFF1976D2),
                  icon: Icons.air,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildActionButton(
            context,
            "Contact Driver",
            const Color(0xFF007BFF),
            Colors.white,
            onTap: () {
              print("Contacting Driver...");
            },
          ),
        ],
      ),
    );
  }

  Widget _featureBox(
      String title, String main, String sub, Color bg, Color accent,
      {IconData? icon}) {
    return Container(
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: accent,
            radius: 20,
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 10),
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 11, color: accent, fontWeight: FontWeight.w500)),
          if (main.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(main,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: accent)),
            Text(sub, style: TextStyle(fontSize: 11, color: accent)),
          ],
          if (main.isEmpty) ...[
            const Spacer(),
            Icon(Icons.check_circle_outline, color: accent, size: 22),
            const SizedBox(height: 10),
            Text("Available",
                style: TextStyle(
                    fontSize: 11, color: accent, fontWeight: FontWeight.bold)),
          ],
        ],
      ),
    );
  }

  Widget _buildRoutePlan() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Route Plan",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 20),
          _routeStep("Main Street & Oak Avenue", "7:30 AM",
              const Color(0xFFE8F5E9), const Color(0xFF2E7D32),
              isFirst: true,
              badge: "Your Stop",
              badgeColor: const Color(0xFFE8F5E9),
              badgeTextColor: const Color(0xFF2E7D32)),
          _routeStep("Central Avenue Stop", "7:35 AM", const Color(0xFFE3F2FD),
              const Color(0xFF1976D2)),
          _routeStep("Maple Park Area", "7:42 AM", const Color(0xFFE3F2FD),
              const Color(0xFF1976D2)),
          _routeStep("Highland Shopping Center", "7:48 AM",
              const Color(0xFFE3F2FD), const Color(0xFF1976D2)),
          _routeStep("Oak Street Junction", "7:55 AM", const Color(0xFFE3F2FD),
              const Color(0xFF1976D2)),
          _routeStep("Lincoln Elementary School", "3:30 PM",
              const Color(0xFFFFEBEE), const Color(0xFFC62828),
              isLast: true,
              badge: "School",
              badgeColor: const Color(0xFFFFEBEE),
              badgeTextColor: const Color(0xFFC62828)),
        ],
      ),
    );
  }

  Widget _routeStep(String location, String time, Color iconBg, Color iconColor,
      {bool isFirst = false,
      bool isLast = false,
      String? badge,
      Color? badgeColor,
      Color? badgeTextColor}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration:
                    BoxDecoration(color: iconBg, shape: BoxShape.circle),
                child: Icon(Icons.location_on, color: iconColor, size: 20),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1.5,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        location,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color(0xFF0D1B2A)),
                      ),
                    ),
                    if (badge != null)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                            color: badgeColor,
                            borderRadius: BorderRadius.circular(6)),
                        child: Text(badge,
                            style: TextStyle(
                                color: badgeTextColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.access_time,
                        size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(time,
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13)),
                  ],
                ),
                if (!isLast) const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Reviews",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                    color: const Color(0xFFFFF9C4),
                    borderRadius: BorderRadius.circular(6)),
                child: const Text("2 Reviews",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _reviewItem(
            "Sarah Mitchell",
            "Feb 20, 2026",
            "SM",
            Colors.purple.shade300,
            5,
            "Excellent driver! Always on time and very professional. My daughter feels very safe.",
          ),
          const Divider(height: 32),
          _reviewItem(
            "Michael Chen",
            "Feb 18, 2026",
            "MC",
            Colors.blue.shade300,
            5,
            "Very reliable service. The bus is always clean and the communication is great.",
          ),
        ],
      ),
    );
  }

  Widget _reviewItem(String name, String date, String initial, Color avatarBg,
      int stars, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              backgroundColor: avatarBg,
              radius: 18,
              child: Text(initial,
                  style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
                Text(date,
                    style: const TextStyle(color: Colors.grey, fontSize: 11)),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: List.generate(
            5,
            (i) => Icon(
              Icons.star,
              color: i < stars ? Colors.amber : Colors.grey.shade300,
              size: 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          text,
          style:
              const TextStyle(fontSize: 12, color: Colors.black87, height: 1.4),
        ),
      ],
    );
  }

  Widget _buildActionButton(
      BuildContext context, String label, Color bg, Color text,
      {bool border = false, VoidCallback? onTap}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          foregroundColor: text,
          elevation: 0,
          side: border ? const BorderSide(color: Colors.grey) : null,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
        onPressed: onTap,
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
