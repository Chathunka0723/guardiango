import 'package:flutter/material.dart';

class DriverNotificationsPage extends StatefulWidget {
  const DriverNotificationsPage({super.key});

  @override
  State<DriverNotificationsPage> createState() =>
      _DriverNotificationsPageState();
}

class _DriverNotificationsPageState extends State<DriverNotificationsPage> {
  bool _isAllRead = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3F51B5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Notifications",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF3F51B5),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.notifications_active_outlined,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _isAllRead
                          ? "0 unread notifications"
                          : "3 unread notifications",
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => setState(() => _isAllRead = true),
                  child: Text(
                    _isAllRead ? "All Read" : "Mark all read",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ),
              ],
            ),
          ),

          // --- MAIN SCROLLABLE LIST ---
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 1. Sarah J.
                _buildContactRequestCard(
                  name: "Sarah J.",
                  school: "Lincoln Elementary",
                  pickup: "Main Street area",
                  dropoff: "Lincoln Elementary",
                  notes: "Child needs car seat assistance",
                  time: "5 mins ago",
                  isNew: !_isAllRead,
                ),
                const SizedBox(height: 16),

                // 2. Michael T.
                _buildContactRequestCard(
                  name: "Michael T.",
                  school: "Jefferson High School",
                  pickup: "Downtown Station area",
                  dropoff: "Jefferson High School",
                  notes: "Morning route only",
                  time: "1 hour ago",
                  isNew: !_isAllRead,
                ),
                const SizedBox(height: 16),

                // 3. Emma Wilson Admission
                _buildAdmissionConfirmationCard(
                  parentName: "Emma Wilson",
                  childName: "Alex",
                  time: "2 hours ago",
                  isNew: !_isAllRead,
                ),
                const SizedBox(height: 16),

                // 4. Payment Received (💰)
                _buildSimpleNotification(
                  title: "Payment Received",
                  subtitle: "Payment of \$150.00 received from John Smith",
                  time: "3 hours ago",
                  tag: "payment",
                  tagColor: Colors.amber,
                  icon: Icons.monetization_on_outlined,
                  iconColor: Colors.amber,
                  emoji: "💰",
                ),
                const SizedBox(height: 16),

                // 5. Lost Item Claimed (📦)
                _buildSimpleNotification(
                  title: "Lost Item Claimed",
                  subtitle: "Parent claimed the blue backpack you posted",
                  time: "5 hours ago",
                  tag: "lostItem",
                  tagColor: Colors.purple,
                  icon: Icons.inventory_2_outlined,
                  iconColor: Colors.purple,
                  emoji: "📦",
                ),
                const SizedBox(height: 16),

                // 6. Route Update Required (⚠️)
                _buildActionRequiredCard(
                  title: "Route Update Required",
                  subtitle: "Please update your route schedule for next week",
                  time: "1 day ago",
                  tag: "route",
                  tagColor: Colors.orange,
                  icon: Icons.warning_amber_rounded,
                  iconColor: Colors.orange,
                  emoji: "⚠️",
                  btnLabel: "Update Route",
                ),
                const SizedBox(height: 16),

                // 7. System Announcement (📢)
                _buildSimpleNotification(
                  title: "System Announcement",
                  subtitle:
                      "New safety guidelines have been released. Please review.",
                  time: "2 days ago",
                  tag: "announcement",
                  tagColor: Colors.indigo,
                  icon: Icons.notifications_none_outlined,
                  iconColor: Colors.indigo,
                  emoji: "📢",
                ),
                const SizedBox(height: 16),

                // 8. New Message (💬)
                _buildSimpleNotification(
                  title: "New Message",
                  subtitle:
                      "Parent sent you a message regarding pickup time change",
                  time: "3 days ago",
                  tag: "message",
                  tagColor: Colors.pink,
                  icon: Icons.chat_bubble_outline,
                  iconColor: Colors.pink,
                  emoji: "💬",
                ),

                const SizedBox(height: 25),
                _buildPrivacyFooter(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- REUSABLE CARD BUILDERS ---

  Widget _buildContactRequestCard({
    required String name,
    required String school,
    required String pickup,
    required String dropoff,
    required String notes,
    required String time,
    bool isNew = false,
  }) {
    return _cardWrapper(
      hasBlueEdge: isNew,
      icon: Icons.person_add_outlined,
      iconColor: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (isNew) _newBadge(),
              const SizedBox(width: 8),
              const Text("New Parent Contact Request",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const Spacer(),
              Icon(Icons.delete_outline, color: Colors.grey[400], size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text(
              "$name wants to contact you for transportation to ${school.split(' ')[0]}",
              style: const TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 12),
          _dataBox([
            _detailRow("Parent:", name),
            _detailRow("School:", school),
            _detailRow("Pickup:", pickup),
            _detailRow("Drop-off:", dropoff),
            const Divider(color: Color(0xFFD1E3FF)),
            const Text("Special Notes:",
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500)),
            Text(notes,
                style: const TextStyle(fontSize: 12, color: Colors.black87)),
          ]),
          const SizedBox(height: 12),
          _cardFooter(time, "contact", Colors.blue, showActionRequired: isNew),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _actionBtn(
                      "Accept Request", const Color(0xFF00C853), Colors.white,
                      icon: Icons.check_circle_outline)),
              const SizedBox(width: 12),
              Expanded(
                  child: _actionBtn("Reject", Colors.white, Colors.red,
                      isOutlined: true)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAdmissionConfirmationCard(
      {required String parentName,
      required String childName,
      required String time,
      bool isNew = false}) {
    return _cardWrapper(
      hasBlueEdge: isNew,
      icon: Icons.check_circle_outline,
      iconColor: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_box, color: Colors.green, size: 20),
              const SizedBox(width: 8),
              const Text("Parent Confirmed Admission",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const Spacer(),
              Icon(Icons.delete_outline, color: Colors.grey[400], size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text("$parentName confirmed admission for her child $childName",
              style: const TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 12),
          _cardFooter(time, "admission", Colors.green,
              showActionRequired: isNew),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                  child: _actionBtn("Approve Admission",
                      const Color(0xFF00C853), Colors.white,
                      icon: Icons.check_circle_outline)),
              const SizedBox(width: 12),
              Expanded(
                  child: _actionBtn(
                      "View Details", Colors.white, Colors.black87,
                      isOutlined: true, borderColor: Colors.grey[300])),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSimpleNotification({
    required String title,
    required String subtitle,
    required String time,
    required String tag,
    required Color tagColor,
    required IconData icon,
    required Color iconColor,
    required String emoji,
  }) {
    return _cardWrapper(
      hasBlueEdge: false,
      icon: icon,
      iconColor: iconColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              const Spacer(),
              Icon(Icons.delete_outline, color: Colors.grey[400], size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 12),
          _cardFooter(time, tag, tagColor),
        ],
      ),
    );
  }

  Widget _buildActionRequiredCard({
    required String title,
    required String subtitle,
    required String time,
    required String tag,
    required Color tagColor,
    required IconData icon,
    required Color iconColor,
    required String emoji,
    required String btnLabel,
  }) {
    return _cardWrapper(
      hasBlueEdge: false,
      icon: icon,
      iconColor: iconColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 16)),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              const Spacer(),
              Icon(Icons.delete_outline, color: Colors.grey[400], size: 20),
            ],
          ),
          const SizedBox(height: 4),
          Text(subtitle,
              style: const TextStyle(color: Colors.black54, fontSize: 13)),
          const SizedBox(height: 12),
          _cardFooter(time, tag, tagColor, showActionRequired: true),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),
          _actionBtn(btnLabel, const Color(0xFF2979FF), Colors.white,
              isFullWidth: true),
        ],
      ),
    );
  }

  // --- UI COMPONENT HELPERS ---

  Widget _cardWrapper(
      {required Widget child,
      required IconData icon,
      required Color iconColor,
      bool hasBlueEdge = false}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey[200]!)),
      child: IntrinsicHeight(
        child: Row(
          children: [
            if (hasBlueEdge)
              Container(
                  width: 4,
                  decoration: const BoxDecoration(
                      color: Color(0xFF2979FF),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15)))),
            const SizedBox(width: 12),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: iconColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(icon, color: iconColor, size: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                    child: child)),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _buildFilterChip("All", isSelected: true),
                _buildFilterChip("Contact Requests"),
                _buildFilterChip("Admissions"),
                _buildFilterChip("Payments"),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(children: [
              Container(
                  height: 5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10))),
              Container(
                  height: 5,
                  width: 80,
                  decoration: BoxDecoration(
                      color: const Color(0xFF3F51B5),
                      borderRadius: BorderRadius.circular(10))),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _dataBox(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: const Color(0xFFF0F7FF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFD1E3FF))),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(children: [
        SizedBox(
            width: 60,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500))),
        Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87))),
      ]),
    );
  }

  Widget _cardFooter(String time, String tag, Color tagColor,
      {bool showActionRequired = false}) {
    return Row(children: [
      const Icon(Icons.access_time, size: 14, color: Colors.grey),
      const SizedBox(width: 4),
      Text(time, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      const SizedBox(width: 8),
      _statusTag(tag, tagColor.withOpacity(0.1), tagColor),
      if (showActionRequired) ...[
        const SizedBox(width: 8),
        _statusTag("Action Required", const Color(0xFFFFEBEE), Colors.red),
      ]
    ]);
  }

  Widget _newBadge() {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        color: const Color(0xFF0D47A1),
        child: const Text("NEW",
            style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold)));
  }

  Widget _statusTag(String text, Color bg, Color textCol) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
        child: Text(text,
            style: TextStyle(
                color: textCol, fontSize: 10, fontWeight: FontWeight.w600)));
  }

  Widget _buildFilterChip(String label, {bool isSelected = false}) {
    return Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF3F51B5) : Colors.grey[100],
            borderRadius: BorderRadius.circular(20)),
        child: Text(label,
            style: TextStyle(
                color: isSelected ? Colors.white : Colors.black54,
                fontSize: 13,
                fontWeight: FontWeight.w500)));
  }

  Widget _actionBtn(String label, Color bg, Color text,
      {bool isOutlined = false,
      IconData? icon,
      Color? borderColor,
      bool isFullWidth = false}) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: isOutlined ? (borderColor ?? text) : Colors.transparent)),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        if (icon != null) ...[
          Icon(icon, color: text, size: 16),
          const SizedBox(width: 4)
        ],
        Text(label,
            style: TextStyle(
                color: text, fontWeight: FontWeight.bold, fontSize: 13)),
      ]),
    );
  }

  Widget _buildPrivacyFooter() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
      Icon(Icons.lock_outline, size: 14, color: Color(0xFFFBC02D)),
      SizedBox(width: 5),
      Text(
          "Privacy Protected: Full contact details are only shared after you accept a parent's request",
          style: TextStyle(
              fontSize: 11,
              color: Color(0xFF3F51B5),
              fontWeight: FontWeight.w500)),
    ]);
  }
}
