import 'package:flutter/material.dart';
import 'enter_address_details_screen.dart';

// This is the main widget for the "Confirm Address" screen.
// It's stateful because the bottom panel changes based on location permissions.
class ConfirmAddressScreen extends StatefulWidget {
  const ConfirmAddressScreen({super.key});

  @override
  State<ConfirmAddressScreen> createState() => _ConfirmAddressScreenState();
}

class _ConfirmAddressScreenState extends State<ConfirmAddressScreen> {
  // This boolean controls which bottom sheet is shown.
  // We default to `true` to show the "Location Found" state first.
  bool _locationPermissionGranted = true;

  void _togglePermissionState() {
    setState(() {
      _locationPermissionGranted = !_locationPermissionGranted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // We use a Stack to layer widgets on top of each other.
      // The map is the base layer, and the UI sits on top.
      body: Stack(
        children: [
          // --- MAP PLACEHOLDER ---
          // In a real app, you would replace this Container with a map widget
          // like `google_maps_flutter`.
          Container(
            color:
                const Color(0xFFE5E3DF), // A light gray for the map background
            child: const Center(
              child: Icon(
                Icons.location_on,
                size: 60,
                color: Colors.black54,
              ),
            ),
          ),

          // --- TOP UI ELEMENTS ---
          // We use a SafeArea to avoid the system's top notch/bar.
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Top bar with back arrow and title
                  Row(
                    children: [
                      // Back button
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
                      // Title
                      const Text(
                        'Confirm Address',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Search bar
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
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- BOTTOM PANEL ---
          // This widget is positioned at the bottom of the screen.
          // The content inside changes based on the `_locationPermissionGranted` state.
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _locationPermissionGranted
                ? _buildLocationFoundSheet() // Show this if permission is granted
                : _buildPermissionDeniedSheet(), // Show this if permission is denied
          ),

          // --- FLOATING "LOCATE ME" BUTTON ---
          // This button is positioned relative to the bottom sheet.
          Positioned(
            bottom: _locationPermissionGranted
                ? 210
                : 250, // Adjust position based on sheet height
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement locate me functionality
                },
                icon: const Icon(Icons.my_location),
                label: const Text('Locate Me'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.yellow[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ),
          ),

          // --- DEMO TOGGLE BUTTON ---
          // This button is just for demonstration purposes to let you switch
          // between the two UI states easily. You can remove it in your final app.
          Positioned(
            top: 150,
            right: 16,
            child: ElevatedButton(
              onPressed: _togglePermissionState,
              child: const Text('Toggle UI'),
            ),
          )
        ],
      ),
    );
  }

  // --- WIDGET FOR "LOCATION FOUND" STATE ---
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
        children: [
          const Text(
            'We Found You Here - Let\'s Get Started',
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          // Address info card
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
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('unnamed road',
                          style: TextStyle(color: Colors.white)),
                      SizedBox(height: 4),
                      Text('dubai', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text('Change',
                      style: TextStyle(color: Colors.yellow[700])),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // "Add More Details" button
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGET FOR "PERMISSION DENIED" STATE ---
  Widget _buildPermissionDeniedSheet() {
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
          // "Enable Location" button
          ElevatedButton(
            onPressed: () {},
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
          const SizedBox(height: 12),
          // "Continue With" button
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              side: const BorderSide(color: Colors.white30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child:
                const Text('Continue With Unnamed road, palm jumeirah Dubai'),
          ),
        ],
      ),
    );
  }
}
