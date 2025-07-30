import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  // Controller for interacting with the Google Map.
  final Completer<GoogleMapController> _controller = Completer();

  // The initial camera position for the map.
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // A sample marker to display on the map.
  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('googleplex'),
      position: LatLng(37.42796133580664, -122.085749655962),
      infoWindow:
          InfoWindow(title: 'GooglePlex', snippet: 'The heart of Google'),
    )
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        // The type of map to display (normal, satellite, hybrid, terrain).
        mapType: MapType.hybrid,
        // The initial camera position when the map is first created.
        initialCameraPosition: _kGooglePlex,
        // The set of markers to display on the map.
        markers: _markers,
        // Called when the map is created.
        onMapCreated: (GoogleMapController controller) {
          // Complete the future with the new controller.
          if (!_controller.isCompleted) {
            _controller.complete(controller);
          }
        },
        // Enables the zoom controls (the + and - buttons).
        zoomControlsEnabled: true,
        // Enables the zoom gestures (pinch to zoom).
        zoomGesturesEnabled: true,
        // Enables the compass.
        compassEnabled: true,
        // Enables the my location button.
        // Note: You need to request location permissions separately for this to work.
        myLocationButtonEnabled: true,
        myLocationEnabled: false, // Set to true after handling permissions
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the Lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // A sample location to animate the camera to.
  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  /// Animates the camera to the [_kLake] position.
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
