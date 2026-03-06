import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; 
import 'package:guardiango_app_flutter/splash_screen.dart'; 

// 2. Add 'async' here
void main() async { 
  // 3. This is required when initializing things before runApp
  WidgetsFlutterBinding.ensureInitialized();

  // 4. Initialize Supabase
  await Supabase.initialize(
    url: 'https://qsnmxujrjedgqqryzwdb.supabase.co',        
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFzbm14dWpyamVkZ3Fxcnl6d2RiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzE2NzE0NzQsImV4cCI6MjA4NzI0NzQ3NH0.q5aUgn1FBaMRio9tV1ysAJ2d5juxetu3f4SxIeSnFnI', // <-- Paste your actual Anon Key here
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GuardianGo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFEF3C7)),
        useMaterial3: true,
      ),
      home: const Splashscreen(), 
    );
  }
}