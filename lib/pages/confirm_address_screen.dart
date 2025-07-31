import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
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

  // --- GOOGLE MAPS & PLACES STATE ---
  final Completer<GoogleMapController> _mapController = Completer();

  //! IMPORTANT: Use the same API key you used for Google Maps
  final GoogleMapsPlaces _places =
      GoogleMapsPlaces(apiKey: "AIzaSyByDMlsWnfOAq80DhZccUYTZ-fzLPdCXdw");

  static const LatLng _initialPosition = LatLng(25.2048, 55.2708); // Dubai
  LatLng _currentMapCenter = _initialPosition;

  //! --- SEARCH STATE ---
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  List<Prediction> _predictions = [];

  @override
  void initState() {
    super.initState();
    _locationPermissionGranted = widget.showLocationFoundFirst;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  /// Handles search text changes with a debounce to prevent excessive API calls
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        _searchPlaces(query);
      } else {
        setState(() {
          _predictions = [];
        });
      }
    });
  }

  /// Calls the Google Places API to get autocomplete suggestions
  Future<void> _searchPlaces(String query) async {
    final response = await _places.autocomplete(query);
    if (response.isOkay && response.predictions.isNotEmpty) {
      setState(() {
        _predictions = response.predictions;
      });
    } else {
      setState(() {
        _predictions = [];
      });
    }
  }

  /// Moves the map to the selected place from search results
  Future<void> _selectPlace(Prediction prediction) async {
    final detailsResponse =
        await _places.getDetailsByPlaceId(prediction.placeId!);
    if (detailsResponse.isOkay) {
      final location = detailsResponse.result.geometry!.location;
      final newPosition = LatLng(location.lat, location.lng);

      final controller = await _mapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: newPosition, zoom: 16.0),
      ));

      setState(() {
        _predictions = [];
        _searchController.clear();
        FocusScope.of(context).unfocus(); // Hide keyboard
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // --- GOOGLE MAP WIDGET ---
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
            onCameraMove: (CameraPosition position) {
              setState(() {
                _currentMapCenter = position.target;
              });
            },
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),

          // --- CENTER PIN ICON ---
          const Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Icon(Icons.location_pin, color: Colors.red, size: 50.0),
            ),
          ),

          // --- TOP UI ELEMENTS ---
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
                    ],
                  ),
                  const SizedBox(height: 16),
                  // --- SEARCH BAR ---
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Search for area, street Name ...',
                        hintStyle: const TextStyle(color: Color(0xFF8E8E93)),
                        border: InputBorder.none,
                        prefixIcon:
                            const Icon(Icons.search, color: Colors.grey),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon:
                                    const Icon(Icons.clear, color: Colors.grey),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _predictions = [];
                                  });
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                  // --- SEARCH RESULTS LIST ---
                  if (_predictions.isNotEmpty)
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.builder(
                          itemCount: _predictions.length,
                          itemBuilder: (context, index) {
                            final prediction = _predictions[index];
                            return ListTile(
                              leading: const Icon(Icons.location_on_outlined),
                              title: Text(
                                  prediction.description ?? 'No description'),
                              onTap: () => _selectPlace(prediction),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          // --- BOTTOM PANEL & LOCATE ME BUTTON ---
          // This part remains unchanged from the previous version
          if (_predictions.isEmpty) // Only show when not searching
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _locationPermissionGranted
                  ? _buildLocationFoundSheet()
                  : _buildPermissionDeniedSheet(),
            ),
          if (_locationPermissionGranted && _predictions.isEmpty)
            Positioned(
              bottom: 250, // Adjust this based on your bottom sheet height
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

  // --- HELPER METHODS AND WIDGETS ---
  // These remain largely the same as your previous code.

  Future<void> _locateMe() async {
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      const CameraPosition(target: _initialPosition, zoom: 16.0),
    ));
  }

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
            'Confirm Your Location',
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
                Text('CONFIRM LOCATION', style: TextStyle(color: Colors.white)),
                SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.white, size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionDeniedSheet() {
    // This widget remains the same as your original code
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
