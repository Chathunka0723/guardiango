import 'package:flutter/material.dart';

class AttendanceTrackerPage extends StatelessWidget {
  const AttendanceTrackerPage({super.key});

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
            Text("Attendance Tracker",
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Emma Johnson",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Top Statistics Cards ---
            Row(
              children: [
                Expanded(child: _buildMainStatCard("82%", "Attendance Rate", "18 of 22 days", Colors.green)),
                const SizedBox(width: 12),
                Expanded(child: _buildMainStatCard("91%", "Bus Usage", "20 of 22 days", Colors.blue)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildSmallStatTile("18", "Present", Colors.green),
                _buildSmallStatTile("2", "Late", Colors.orange),
                _buildSmallStatTile("2", "Absent", Colors.red),
              ],
            ),

            const SizedBox(height: 24),

            // --- Attendance Calendar Section ---
            _buildCalendarSection(),

            const SizedBox(height: 24),

            // --- Selection Details Section ---
            _buildSelectionDetails(),

            const SizedBox(height: 20),

            // --- Attendance Notice (Alert) ---
            _buildAttendanceNotice(),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // --- Statistics Card Helper ---
  Widget _buildMainStatCard(String value, String label, String sub, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
          const SizedBox(height: 8),
          Text(sub, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildSmallStatTile(String value, String label, Color color) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Icon(
            label == "Present" ? Icons.check_circle_outline : (label == "Late" ? Icons.access_time : Icons.cancel_outlined),
            color: color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        ],
      ),
    );
  }

  // --- Calendar Component ---
  Widget _buildCalendarSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.calendar_today, size: 20),
              SizedBox(width: 8),
              Text("Attendance Calendar", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem(Colors.green, "Present"),
              _buildLegendItem(Colors.orange, "Late"),
              _buildLegendItem(Colors.red, "Absent"),
              _buildLegendItem(Colors.blue, "Bus", isIcon: true),
            ],
          ),
          const SizedBox(height: 16),
          // Month Selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.chevron_left),
              Row(
                children: [
                  _buildDropdown("Jan"),
                  const SizedBox(width: 8),
                  _buildDropdown("2026"),
                ],
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
          const SizedBox(height: 16),
          // Simple Grid Implementation for UI Similarity
          _buildCalendarGrid(),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label, {bool isIcon = false}) {
    return Row(
      children: [
        isIcon ? Icon(Icons.directions_bus, size: 12, color: color) : Icon(Icons.circle, size: 10, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildDropdown(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const Icon(Icons.arrow_drop_down, size: 16),
        ],
      ),
    );
  }

  Widget _buildCalendarGrid() {
    // සරල උදාහරණයක් ලෙස දින දර්ශන ග්‍රිඩ් එක මෙසේ නිර්මාණය කර ඇත
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
      ),
      itemCount: 35,
      itemBuilder: (context, index) {
        if (index < 7) {
          const days = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];
          return Center(child: Text(days[index], style: const TextStyle(fontSize: 10, color: Colors.grey)));
        }
        int day = index - 6;
        Color? bgColor;
        if ([1, 2, 4, 5, 8, 9, 10, 11, 12, 16, 19, 22, 23, 24, 25, 26].contains(day)) bgColor = Colors.green;
        if ([3, 18].contains(day)) bgColor = Colors.orange;
        if ([15, 17].contains(day)) bgColor = Colors.red;

        return Container(
          decoration: BoxDecoration(
            color: bgColor ?? Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              day > 31 ? "" : day.toString(),
              style: TextStyle(
                fontSize: 12,
                color: bgColor != null ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  // --- Details Card ---
  Widget _buildSelectionDetails() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Tuesday, January 23, 2026", style: TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          _buildDetailRow("Attendance Status", "Present", Colors.black),
          const SizedBox(height: 12),
          _buildDetailRow("Bus Usage", "Boarded Bus", Colors.black),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String status, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
          child: Text(status, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // --- Alert Notice ---
  Widget _buildAttendanceNotice() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.red.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.cancel, color: Colors.red, size: 20),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Attendance Notice", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  "Your child has been absent 2 days this month. Please ensure regular attendance for optimal learning.",
                  style: TextStyle(color: Colors.redAccent, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}