import 'package:flutter/material.dart';
import 'confirm_address_screen.dart';

class LocationData {
  final String name;
  final String address;
  final String type;
  final double lat;
  final double lng;

  const LocationData({
    required this.name,
    required this.address,
    required this.type,
    required this.lat,
    required this.lng,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<LocationData> _allLocations = [
    const LocationData(
        name: 'Salsa dance by DD Studio',
        address: '123 Dance Ave, Dubai',
        type: 'class',
        lat: 25.2048,
        lng: 55.2708),
    const LocationData(
        name: 'Hip Hop with B-Boy Mike',
        address: '456 Groove St, Dubai',
        type: 'class',
        lat: 25.276987,
        lng: 55.296249),
    const LocationData(
        name: 'Ballet Basics',
        address: '789 Pirouette Pl, Sharjah',
        type: 'class',
        lat: 25.3463,
        lng: 55.4209),
    const LocationData(
        name: 'Desert Safari Adventure',
        address: 'Al Awir Desert, Dubai',
        type: 'experience',
        lat: 25.1325,
        lng: 55.5902),
    const LocationData(
        name: 'Dhow Cruise Dinner',
        address: 'Dubai Marina',
        type: 'experience',
        lat: 25.0770,
        lng: 55.1338),
    const LocationData(
        name: 'Burj Khalifa Tour',
        address: 'Downtown Dubai',
        type: 'experience',
        lat: 25.1972,
        lng: 55.2744),
    const LocationData(
        name: 'Home',
        address: 'Unnamed road, palm jumeirah Dubai',
        type: 'saved',
        lat: 25.1182,
        lng: 55.1387),
    const LocationData(
        name: 'webninjaz',
        address: 'C40, C Block, Sector 58, Noida',
        type: 'saved',
        lat: 28.6033,
        lng: 77.3792),
    const LocationData(
        name: 'Supertech',
        address: 'Capetown, Sector 74, Noida',
        type: 'saved',
        lat: 28.5815,
        lng: 77.3835),
  ];

  List<LocationData> _filteredLocations = [];

  @override
  void initState() {
    super.initState();
    _filteredLocations = [];
    _searchController.addListener(_performSearch);
  }

  @override
  void dispose() {
    _searchController.removeListener(_performSearch);
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        _filteredLocations = [];
      });
      return;
    }
    final filteredList = _allLocations.where((location) {
      final nameMatches = location.name.toLowerCase().contains(query);
      final addressMatches = location.address.toLowerCase().contains(query);
      return nameMatches || addressMatches;
    }).toList();

    setState(() {
      _filteredLocations = filteredList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSearching = _searchController.text.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        size: 28, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      autofocus: true,
                      style: const TextStyle(color: Colors.white, fontSize: 17),
                      decoration: InputDecoration(
                        hintText: 'Search for area, street Name ...',
                        hintStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 17),
                        filled: true,
                        fillColor: const Color(0xFF2C2C2E),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22.0),
                          borderSide: BorderSide.none,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        suffixIcon: isSearching
                            ? IconButton(
                                icon:
                                    Icon(Icons.close, color: Colors.grey[400]),
                                onPressed: () => _searchController.clear(),
                              )
                            : null,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.location_on_outlined,
                        size: 28, color: Colors.white),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConfirmAddressScreen(
                              showLocationFoundFirst: true),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: isSearching
                      ? _buildSearchResults()
                      : _buildDefaultContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_filteredLocations.isEmpty) {
      return const Center(
        child: Text('No results found',
            style: TextStyle(color: Colors.white70, fontSize: 16)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: _filteredLocations.length,
      itemBuilder: (context, index) {
        final location = _filteredLocations[index];
        //! Made the search result item tappable
        return InkWell(
          onTap: () {
            //* Navigate to the map screen, passing the selected coordinates
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConfirmAddressScreen(
                  showLocationFoundFirst: true,
                  // initialTarget: LatLng(location.lat, location.lng),
                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: NearbyLocationTile(
              name: location.name,
              address: location.address,
            ),
          ),
        );
      },
    );
  }

  Widget _buildDefaultContent() {
    //* This widget remains the same
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recently Classes',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => const DanceClassItem(),
            separatorBuilder: (context, index) => const SizedBox(height: 12),
          ),
          const SizedBox(height: 30),
          const Text('Recently Experiences',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) => const DanceClassItem(),
            separatorBuilder: (context, index) => const SizedBox(height: 20),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class DanceClassItem extends StatelessWidget {
  const DanceClassItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              color: const Color(0xFF3A302B),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const Icon(Icons.music_note, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(width: 12),
        const Text('Salsa dance by DD Studio',
            style: TextStyle(fontSize: 12, color: Colors.white)),
      ],
    );
  }
}

class NearbyLocationTile extends StatelessWidget {
  final String name;
  final String address;
  const NearbyLocationTile(
      {super.key, required this.name, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: const BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFF2C2C2E), width: 1))),
      child: Row(
        children: [
          const Icon(Icons.location_pin, color: Color(0xFF8E8E93), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(fontSize: 16, color: Colors.white)),
                const SizedBox(height: 4),
                Text(address,
                    style: const TextStyle(
                        color: Color(0xFF8E8E93), fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
