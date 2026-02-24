import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/SplashScreen.dart'; 


void main()  {
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
      home: Splashscreen(), 
    );
  }
}