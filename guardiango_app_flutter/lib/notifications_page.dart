import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // 1. We create a 'Stream'. This is a live pipe to your SQL 'notifications' table.
  // It only picks up notifications where the receiver_id is the person currently logged in.
  final _notificationStream = Supabase.instance.client
      .from('notifications')
      .stream(primaryKey: ['id'])
      .eq('receiver_id', Supabase.instance.client.auth.currentUser!.id)
      .order('created_at');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor:
            const Color(0xFFFEF3C7), // Matching your GuardianGo yellow
      ),
      // 2. StreamBuilder is a 'Magic Box'. Every time your SQL Trigger adds a row,
      // this box 'rebuilds' itself instantly.
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _notificationStream,
        builder: (context, snapshot) {
          // CHECK 1: Is there an error? (No internet, SQL error, etc.)
          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 48, color: Colors.redAccent),
                  const SizedBox(height: 16),
                  const Text("Unable to load notifications",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  TextButton(
                    onPressed: () =>
                        setState(() {}), // Triggers a rebuild to try again
                    child: const Text("Try Again"),
                  ),
                ],
              ),
            );
          }
          // If the internet is slow or it's still loading
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications = snapshot.data!;

          // If there are no notifications yet
          if (notifications.isEmpty) {
            return const Center(
                child: Text("No notifications yet. You're all caught up!"));
          }

          // 3. ListView builds the list you see on the screen
          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final item = notifications[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.notifications, color: Colors.white),
                  ),
                  title: Text(item['title'] ?? 'New Alert',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(item['message'] ?? ''),
                  trailing: Text(
                    // This shows the time from your 'created_at' column
                    item['created_at'].toString().substring(11, 16),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
