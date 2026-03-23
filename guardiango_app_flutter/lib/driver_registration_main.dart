import 'package:flutter/material.dart';
import 'package:guardiango_app_flutter/driver_registration_page1.dart';
import 'package:guardiango_app_flutter/driver_registration_page2.dart';
import 'package:guardiango_app_flutter/driver_registration_page3.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:guardiango_app_flutter/registration_submitted_screen.dart';

class DriverRegistrationMain extends StatefulWidget {
  const DriverRegistrationMain({super.key});

  @override
  State<DriverRegistrationMain> createState() => _DriverRegistrationMainState();
}

class _DriverRegistrationMainState extends State<DriverRegistrationMain> {

  final PageController _pageController = PageController();

  String? userId;
  Map<String, dynamic>? vehicleData;
  Map<String, dynamic>? routeData;

  Future<void> _submitRegistration() async {
    print("SUBMIT FUNCTION CALLED");

    if (userId == null) {
      print("User ID is null");
      return;
    }

    final supabase = Supabase.instance.client;

    await supabase.from('profile').update({
      'vehicle_model': vehicleData?['vehicle_model'],
      'vehicle_number': vehicleData?['vehicle_number'],
      'seats': int.tryParse(vehicleData?['seats'].toString() ?? '0'),
      'starting_city': routeData?['starting_city'],
      'departure_time': routeData?['departure_time']?.toString(),
      'route_stops': routeData?['stops'],
      'status': 'pending',
    }).eq('profile_id', userId!);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const RegistrationSubmittedScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [

          DriverRegistrationPage1(
            pageController: _pageController,
            onSuccess: (id) {
              userId = id;
            },
          ),

          DriverRegistrationPage2(
            pageController: _pageController,
            onNext: (data) {
              vehicleData = data;
            },
          ),

          DriverRegistrationPage3(
            pageController: _pageController,
            onFinish: (data) {
              routeData = data;
            },
            onSubmit: _submitRegistration,
          ),
        ],
      ),
    );
  }
}