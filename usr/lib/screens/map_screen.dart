import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  
  final LatLng _center = const LatLng(23.8103, 90.4125); // Dhaka coordinates
  
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dealer Locations'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
        markers: _createMarkers(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to visit list
          Navigator.pushNamed(context, '/visit_list');
        },
        child: const Icon(Icons.list),
      ),
    );
  }
  
  Set<Marker> _createMarkers() {
    return {
      const Marker(
        markerId: MarkerId('dealer1'),
        position: LatLng(23.8103, 90.4125),
        infoWindow: InfoWindow(title: 'ABC Electronics'),
      ),
      const Marker(
        markerId: MarkerId('dealer2'),
        position: LatLng(23.8203, 90.4225),
        infoWindow: InfoWindow(title: 'XYZ Traders'),
      ),
    };
  }
}
