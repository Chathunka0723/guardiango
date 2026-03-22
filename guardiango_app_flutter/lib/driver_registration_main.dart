import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/driver_registration_page1.dart';
import 'package:guardiango_app_flutter/driver_registration_page2.dart';
import 'package:guardiango_app_flutter/driver_registration_page3.dart';

class DriverRegistrationMain extends StatefulWidget {
  const DriverRegistrationMain({super.key});

  @override
  State<DriverRegistrationMain> createState() => _DriverRegistrationMainState();
}

class _DriverRegistrationMainState extends State<DriverRegistrationMain> {

  final PageController _pageController = PageController();

  String? userId; 

  
  Future<String?> getVehicleCode(String userId) async {
    final data = await Supabase.instance.client
        .from('profiles')
        .select('vehicle_code')
        .eq('id', userId)
        .single();

    return data['vehicle_code'];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


Future<void> _submitRegistration() async {
  if (userId == null) {
    // Handle the case where userId is not available
    return;
  }
  String? vehicleCode = await getVehicleCode(userId!);

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => RegistrationApprovedScreen(
        vehicleCode: vehicleCode,
      ),
    ),
  );
}
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Prevent manual swipe
        children: [
          DriverRegistrationPage1(pageController: _pageController),
          DriverRegistrationPage2(pageController: _pageController),
          DriverRegistrationPage3(pageController: _pageController, onSubmit: _submitRegistration),
        ],
      ),
    );
  }
}
