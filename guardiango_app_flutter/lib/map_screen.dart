import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // මේක අනිවාර්යයි

class MapScreen extends StatefulWidget {
  final String busId; // බස් එක හඳුනාගන්න ID එකක් අවශ්‍යයි
  const MapScreen({super.key, required this.busId});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // ආරම්භක ස්ථානය (දත්ත එනකම් පෙන්වන්න)
  static const LatLng _initialLocation = LatLng(6.9271, 79.8612);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GuardianGo - Live Tracking'),
        backgroundColor: Colors.blueAccent,
      ),
      // මෙන්න මෙතැනටයි StreamBuilder එක එන්නේ
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Supabase.instance.client
            .from('bus_Location') // ඔයාගේ table නම
            .stream(primaryKey: ['bus_location_id']) // Primary key එක
            .eq('bus_id', widget.busId) // අදාළ බස් එක විතරක් ගන්න
            .order('recorded_at'), // අලුත්ම දත්තය පිළිවෙළට ගන්න
        builder: (context, snapshot) {
          // දත්ත එනකම් loading සලකුණක් පෙන්වමු
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Supabase එකෙන් එන අලුත්ම දත්තය (latitude සහ longitude)
          final data = snapshot.data!.last; 
          final double lat = data['latitude'];
          final double lng = data['longitude'];
          final LatLng busPosition = LatLng(lat, lng);

          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: busPosition,
              zoom: 15.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('live_bus'),
                position: busPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
                infoWindow: InfoWindow(title: 'Bus is here', snippet: 'Speed: ${data['speed']} km/h'),
              ),
            },
          );
        },
      ),
    );
  }
}