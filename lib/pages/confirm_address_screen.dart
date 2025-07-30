import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'enter_address_details_screen.dart';

class ConfirmAddressScreen extends StatefulWidget {
  final bool showLocationFoundFirst;

  const ConfirmAddressScreen({
    super.key,
    required this.showLocationFoundFirst,
  });

  @override
  State<ConfirmAddressScreen> createState() => _ConfirmAddressScreenState();
}

class _ConfirmAddressScreenState extends State<ConfirmAddressScreen> {
  late bool _locationPermissionGranted;

  final Completer<GoogleMapController> _mapController = Completer();

  static const LatLng _initialPosition = LatLng(25.2048, 55.2708);

  LatLng _currentMapCenter = _initialPosition;

  @override
  void initState() {
    super.initState();
    _locationPermissionGranted = widget.showLocationFoundFirst;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //! --- GOOGLE MAP WIDGET ---
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: _initialPosition,
              zoom: 14.0,
            ),
            onMapCreated: (GoogleMapController controller) {
              if (!_mapController.isCompleted) {
                _mapController.complete(controller);
              }
            },
            //* This updates our state variable every time the map moves
            onCameraMove: (CameraPosition position) {
              setState(() {
                _currentMapCenter = position.target;
              });
            },
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),

          //! --- CENTER PIN ICON ---
          //* This pin stays in the center while the map moves underneath it
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Icon(
                Icons.location_pin,
                color: Colors.red,
                size: 50.0,
              ),
            ),
          ),

          //! --- TOP UI ELEMENTS ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search for area, street Name ...',
                      hintStyle: TextStyle(color: Color(0xFF8E8E93)),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //! --- BOTTOM PANEL ---
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _locationPermissionGranted
                ? _buildLocationFoundSheet()
                : _buildPermissionDeniedSheet(),
          ),

          //! --- FLOATING "LOCATE ME" BUTTON ---
          if (_locationPermissionGranted)
            Positioned(
              bottom: 250,
              right: 20,
              child: FloatingActionButton(
                onPressed: _locateMe,
                backgroundColor: Colors.white,
                child: const Icon(Icons.my_location, color: Colors.black),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _locateMe() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      const CameraPosition(
        target: _initialPosition,
        zoom: 16.0,
      ),
    ));
  }

  //! --- WIDGET FOR "LOCATION FOUND" STATE ---
  Widget _buildLocationFoundSheet() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'We Found You Here - Let\'s Get Started',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1C1C1E),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined, color: Colors.yellow[700]),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Lat: ${_currentMapCenter.latitude.toStringAsFixed(4)}',
                          style: const TextStyle(color: Colors.white)),
                      const SizedBox(height: 4),
                      Text(
                          'Lng: ${_currentMapCenter.longitude.toStringAsFixed(4)}',
                          style: const TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Change',
                      style: TextStyle(color: Colors.yellow[700])),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const EnterAddressDetailsScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 48, 39, 236),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ADD MORE ADDRESS DETAILS',
                    style: TextStyle(color: Colors.white)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //! --- WIDGET FOR "PERMISSION DENIED" STATE ---
  Widget _buildPermissionDeniedSheet() {
    //* This sheet remains the same as your original code
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Location permission not enabled',
            style: TextStyle(
                color: Colors.yellow,
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Please enable location permission to give us your exact address',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              //* This logic might need adjustment. For now, it just reloads the screen.
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const ConfirmAddressScreen(
                        showLocationFoundFirst: true)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 48, 39, 236),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enable device Location',
                    style: TextStyle(color: Colors.white)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
