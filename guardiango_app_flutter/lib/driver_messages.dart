import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

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
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Messages",
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            Text("Parent communications",
                style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        ),
      ),
      body: Column(
        children: [
          // 1. Search Bar Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search conversations...",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF1F3F4),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 2. Urgent Alert Box (Now with the Yellow Icon too)
                _buildUrgentAlert(),
                const SizedBox(height: 16),

                // 3. Message List
                _messageCard(
                  name: "Sarah Johnson",
                  parentOf: "Emma Johnson",
                  message: "Thank you for letting me know!",
                  time: "10:32 AM",
                ),
                _messageCard(
                  name: "Lisa Chen",
                  parentOf: "Michael Chen",
                  message: "What time will you arrive at the stop?",
                  time: "10:15 AM",
                  isUrgent: true,
                  unreadCount: 2,
                ),
                _messageCard(
                  name: "Maria Rodriguez",
                  parentOf: "Sofia Rodriguez",
                  message: "Sofia will be ready at the stop",
                  time: "Yesterday",
                ),
                _messageCard(
                  name: "David Wilson",
                  parentOf: "James Wilson",
                  message: "Thanks for the update",
                  time: "Yesterday",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrgentAlert() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF5F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFFE3E3)),
      ),
      child: Row(
        children: [
          // CENTERED PERSON ICON IN YELLOW CIRCLE
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: Color(0xFFFFC107),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(Icons.person, color: Colors.white, size: 22),
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              "You have urgent unread messages that require attention.",
              style: TextStyle(color: Color(0xFF7B1D1D), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageCard({
    required String name,
    required String parentOf,
    required String message,
    required String time,
    bool isUrgent = false,
    int unreadCount = 0,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F3F4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // THE YELLOW CIRCLE WITH CENTERED PERSON ICON
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFC107),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Icon(Icons.person, color: Colors.white, size: 32),
                ),
              ),
              if (unreadCount > 0)
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Name and Urgent Badge side-by-side
                    Row(
                      children: [
                        Text(name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        if (isUrgent) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFEBEE),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text("Urgent",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ],
                    ),
                    Text(time,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text("Parent of $parentOf",
                    style:
                        const TextStyle(color: Colors.blueGrey, fontSize: 12)),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: TextStyle(
                    color: isUrgent ? Colors.black : Colors.grey[700],
                    fontWeight: isUrgent ? FontWeight.bold : FontWeight.normal,
                    fontSize: 14,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
